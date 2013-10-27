#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILE="$( pwd )/$1"
# echo $FILE

mkdir -p books
(
  cd books
  cat ${FILE} | parallel --gnu echo '***' {}\; "${DIR}/download-prepare.sh" {}
)
