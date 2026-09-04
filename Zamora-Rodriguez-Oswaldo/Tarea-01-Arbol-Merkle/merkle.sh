#!/bin/bash

calcular_hash() {
    local ruta="$1"

    if [ -f "$ruta" ]; then
        md5sum "$ruta" | cut -d ' ' -f 1
    elif [ -d "$ruta" ]; then
        find "$ruta" -type f -exec stat -c '%n %s %Y %a' {} \; \
            | sort \
            | md5sum \
            | cut -d ' ' -f 1
    else
        echo "Error: la ruta no existe" >&2
        return 1
    fi
}

if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <archivo_o_directorio>"
    exit 1
fi

calcular_hash "$1"
