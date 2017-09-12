#! /bin/bash

set -euo pipefail
IFS=$'\n\t'

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd)

ALL=
COMMON_ARGS=
TAG="local"
USERNAME=joelnb
VERBOSE=

build_all_images() {
	while read -rd $'\0' imagedir; do
		build_image_dir "${imagedir}"
	done < <(find "${DIR}" -mindepth 1 -maxdepth 1 -not -name ".git" -type d -print0)
}

build_image_dir() {
	local path="${1:-}"

	if [ -z "${path}" ]; then
		return 1
	fi

	local image_name="$(basename "${path}")"
	local whole_tag="${TAG}"

	if [ -n "${whole_tag}" ]; then
		whole_tag=":${whole_tag}"
	fi

	echo "==>" docker build -t "${USERNAME}/${image_name}${whole_tag}""${COMMON_ARGS}" "${path}"
	eval docker build -t "${USERNAME}/${image_name}${whole_tag}""${COMMON_ARGS}" "${path}"

	for dir in $(ls "${path}" | grep Dockerfile- | sed 's/Dockerfile-//'); do
		local this_image_tag=":${dir}"
		if [ -n "${TAG}" ]; then
			this_image_tag=":${TAG}-${dir}"
		fi

		echo "==>" docker build -t "${USERNAME}/${image_name}${this_image_tag}""${COMMON_ARGS}" "${path}"
		eval docker build -t "${USERNAME}/${image_name}${this_image_tag}""${COMMON_ARGS}" "${path}"
	done
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
   -t TAG       A tag to apply to the built image [default: local].
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
			TAG="$OPTARG"
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

if [ -n "${1:-}" ]; then
	echo "Unknown arguments: $@"
	usage
fi

if [ -z "${DIRECTORY}" ]; then
	build_all_images
else
	build_image_dir "${DIRECTORY}"
fi
