#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

parallel --gnu --jobs 12 gunzip -c {} \
| LC_ALL=C sort \
| uniq -c \
| awk '{ printf("%9s %s\n", $1, $2) }'

