#! /bin/bash

# Downloads a .deb package and all dependencies so that it can be installed on
# an offline computer
get_complete_deb() {
    local pkgname="$1"

    if [ -z "$pkgname" ]; then
        echo "Please specifiy a package"
        return 1
    fi

    tmpfile=$(mktemp /tmp/get_complete_deb.XXXXXXX)
    apt-get --print-uris --yes install "$1" | grep ^\' | cut -d\' -f2 > "$tmpfile"
    wget --no-clobber --input-file "$tmpfile"
    rm "$tmpfile"
}

if [ "$#" -lt "1" ]; then
    echo "Usage: $(basename "$0") PACKAGE..."
    exit 1
fi

apt-get -q update

for pkgname in "$@"; do
    get_complete_deb "${pkgname}"
done
