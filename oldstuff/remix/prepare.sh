#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
EPUBFILE="$1"
TXTFILE="${EPUBFILE%.epub}.txt"
BASE="${EPUBFILE%.epub}"

echo
echo "Converting $EPUBFILE to text..."

"${DIR}/epub2txt" "${EPUBFILE}" >"${TXTFILE}"

echo "Cleaning $EPUBFILE text..."
cat "${TXTFILE}" \
| "${DIR}/filtergoogle" \
| "${DIR}/cleantext" \
> "${BASE}-words.txt"

echo "Removing ${TXTFILE}"
rm -f "${TXTFILE}"

echo "Uploading ${BASE}-words.txt"
"$DIR/upcs" -q -c research "${BASE}-words.txt" \

for N in 1 2 3 4 5; do
  NGRAMFILE="${BASE}-${N}grams.txt.gz"
  echo "Creating $NGRAMFILE"
  cat "${BASE}-words.txt" \
  | "${DIR}/mkngrams" -n ${N} -b \
  | gzip -c \
  >"$NGRAMFILE"

  echo "Uploading $NGRAMFILE"
  "$DIR/upcs" -q -c research "$NGRAMFILE" \
  && (
    echo "Removing $NGRAMFILE"
    rm -f "$NGRAMFILE"
  )
done

echo "Removing ${BASE}-words.txt"
rm -f "${BASE}-words.txt"
