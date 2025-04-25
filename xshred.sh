#!/bin/sh
confirm() {
    printf "shred '%s'? [y/N] " "$1"
    read ans
    [ "$ans" = "y" ] || return 1
    return 0
}

shred_recursive() {
    for target in "$@"; do
        if [ -d "$target" ]; then
            # Depth-first: files first
            find "$target" -type f | while IFS= read -r file; do
                confirm "$file" && shred -uz "$file"
            done
find "$target" -type f | while IFS= read -r file; do
    case "$file" in
        '/'|'/boot'|'/bin'|'/etc'|'/usr'|'/lib'*|'/sbin'|'/dev'|'/proc'|'/sys')
            echo "skipping protected path: $file" >&2
            continue ;;
    esac
    confirm "$file" && shred -uz "$file"
done
        elif [ -f "$target" ]; then
            confirm "$target" && shred -uz "$target"
        else
            echo "skipped: '$target' is not a file or directory" >&2
        fi
    done
}

shred_recursive "$@"


