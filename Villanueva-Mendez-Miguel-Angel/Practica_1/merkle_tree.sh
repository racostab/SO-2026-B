#!/bin/bash

merkle_hash() {
    local dir="$1"
    local hashes=""
    
    for item in $(ls -A "$dir" | sort); do
        local path="$dir/$item"
        
        if [[ -f "$path" ]]; then
            hash=$(sha1sum "$path" | cut -d' ' -f1)
            hashes="${hashes}file:$item:$hash\n"
       
        elif [[ -d "$path" ]]; then
            child_hash=$(merkle_hash "$path")
            hashes="${hashes}dir:$item:$child_hash\n"
        fi
    done

    echo -e "$hashes" | sha1sum | cut -d' ' -f1
}

if [[ $# -ne 1 ]] || [[ ! -d "$1" ]]; then
    echo "Uso: $0 <directorio>"
    exit 1
fi

root_hash=$(merkle_hash "$1")
echo "Hash Merkle raíz: $root_hash"
