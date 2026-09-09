#!/usr/bin/env bash
#
# Export an Mplify HTML deck to PDF.
#
#   tools/export-pdf.sh                       # index.html -> index.pdf
#   tools/export-pdf.sh path/to/deck.html     # -> path/to/deck.pdf
#   tools/export-pdf.sh deck.html out.pdf     # explicit output
#
# There is nothing to install. The deck carries its own print stylesheet (the
# PRINT / PDF EXPORT block in its <style>), so this script only has to open it
# with ?print=1 and ask Chrome to print. Cmd+P -> Save as PDF in any browser
# uses that same stylesheet, so the two routes cannot drift apart.
#
# ?print=1 makes the deck build its print pages up front instead of waiting for
# a beforeprint event, which headless Chrome does not reliably fire. Every slide
# gets a page, and every zoomable diagram gets a page of its own after the slide
# it belongs to - at tile size those SVGs are unreadable on paper. Page size and
# margins come from the deck's own @page rule, not from here.
#
# Env: CHROME=/path/to/chrome   BUDGET=<ms>   (font/layout settling time)

set -euo pipefail

CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
BUDGET="${BUDGET:-10000}"

[ -x "$CHROME" ] || { echo "Chrome not found at: $CHROME" >&2
                      echo "Set CHROME=/path/to/chrome and re-run." >&2; exit 1; }

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
input="${1:-$repo_root/index.html}"
[ -f "$input" ] || { echo "No such deck: $input" >&2; exit 1; }

input_abs="$(cd "$(dirname "$input")" && pwd)/$(basename "$input")"
output="${2:-${input_abs%.html}.pdf}"

profile="$(mktemp -d)"
trap 'rm -rf "$profile"' EXIT
rm -f "$output"

echo "Deck   $input_abs"
echo "PDF    $output"

# Headless Chrome writes the PDF and then, more often than not, does not exit.
# Rather than wait out a timeout, watch for the file to appear and stop growing,
# then stop the browser. A stopped Chrome after a complete write is a success.
set +e
"$CHROME" \
  --headless=new \
  --disable-gpu \
  --no-first-run \
  --no-default-browser-check \
  --user-data-dir="$profile" \
  --no-pdf-header-footer \
  --run-all-compositor-stages-before-draw \
  --virtual-time-budget="$BUDGET" \
  --print-to-pdf="$output" \
  "file://${input_abs}?print=1" >/dev/null 2>&1 &
chrome_pid=$!

size_of() { stat -f%z "$1" 2>/dev/null || stat -c%s "$1" 2>/dev/null || echo 0; }

last=0; stable=0; waited=0; limit=120
while [ "$waited" -lt "$limit" ]; do
  kill -0 "$chrome_pid" 2>/dev/null || break        # exited on its own
  sleep 1; waited=$((waited + 1))
  [ -s "$output" ] || continue
  size="$(size_of "$output")"
  if [ "$size" = "$last" ]; then
    stable=$((stable + 1)); [ "$stable" -ge 2 ] && break
  else
    stable=0
  fi
  last="$size"
done

kill "$chrome_pid" 2>/dev/null
wait "$chrome_pid" 2>/dev/null
status=0
set -e

if [ ! -s "$output" ]; then
  echo "Chrome exited $status and produced no PDF." >&2
  echo "Try: CHROME='$CHROME' BUDGET=20000 $0 $*" >&2
  exit 1
fi

pages="$(python3 -c "
import re,sys
d=open(sys.argv[1],'rb').read()
print(len(re.findall(rb'/Type\s*/Page[^s]', d)))" "$output" 2>/dev/null || echo '?')"

printf 'Done   %s, %s pages\n' "$(du -h "$output" | cut -f1)" "$pages"
[ "$status" -ne 0 ] && echo "       (Chrome lingered and was stopped after writing; the PDF is complete)"
exit 0
