#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILE=$1

echo "Downloading ${FILE}"

rumm download file ${FILE} in container research

mv "download-$1" ${FILE} \
&& "$DIR/prepare.sh" ${FILE}

echo "Removing ${FILE}"
rm -f ${FILE}