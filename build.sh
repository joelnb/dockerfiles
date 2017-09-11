#! /bin/bash

set -euo pipefail
IFS=$'\n\t'

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)

ALL=
COMMON_ARGS=
TAG=
USERNAME=joelnb
VERBOSE=

build_all_images() {
	while read -rd $'\0' imagedir; do
		build_single_image "${imagedir}"
	done < <(find "${DIR}" -mindepth 1 -maxdepth 1 -not -name ".git" -type d -print0)
}

build_single_image() {
	local path="${1:-}"

	if [ -z "${path}" ]; then
		return 1
	fi

	local image_name=$(basename "${path}")

	eval docker build -t "${USERNAME}/${image_name}${TAG}" "${COMMON_ARGS}" "${path}"
}

usage() {
	cat <<EOF
usage: $(basename "$0") [DIRECTORY]

Build dockerfiles for testing.

ARGUMENTS:
   DIRECTORY    The directory containing the Dockerfile. If no directory
                is specified as then all directories in the same location
                as this script will be built.

OPTIONS:
   -h           Show this message.
   -n           Pass the '--no-cache' option to docker build.
   -t TAG       A tag to apply to the built image.
   -u USER      The username to name images under [default: ${USERNAME}]
   -V           Increase output verbosity.
EOF
	exit 1
}

while getopts "hnt:u:V" OPTION; do
	case $OPTION in
		h)
			usage
			;;
		n)
			COMMON_ARGS="${COMMON_ARGS} --no-cache"
			;;
		t)
			TAG=":$OPTARG"
			;;
		u)
			USERNAME=$OPTARG
			;;
		V)
			VERBOSE=1
			;;
		?)
			usage
			;;
	esac
done

shift $(($OPTIND - 1))

DIRECTORY="${1:-}"
[ -n "${DIRECTORY}" ] && shift

if [ -z "${DIRECTORY}" ]; then
	build_all_images
else
	build_single_image "${DIRECTORY}"
fi
