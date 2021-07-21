#!/usr/bin/env bash
failed=false

for file in "$@"; do
    newFile=$(cat $file | sed "/---.*/,/---.*/s/^last_modified_at:.*$/last_modified_at: $(date -u "+%Y-%m-%d")/")
    currentFile=$(cat $file)

    if [[ ! -z "$newFile" ]]
    then
        if [[ "$newFile" != "$currentFile" ]]; then
            failed=true
            echo "$newFile" > $file
        fi
    fi
done


if [[ $failed == "true" ]]; then
    exit 1
fi
