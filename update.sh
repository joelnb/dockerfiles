#! /usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)

for image in $(find "${DIR}" -mindepth 1 -maxdepth 1 -not -name .git -type d -execdir grep -hr FROM {} \; | cut -d' ' -f 2 | sort | uniq); do \
	echo "=> $image" ; \
	docker pull "${image}" ; \
done
