#!/bin/bash

# ============================================================
# Árbol de Merkle utilizando metadatos de archivos y directorios
# ============================================================

# ------------------------------------------------------------
# Calcula el hash de una cadena
# ------------------------------------------------------------
hash_string() {
    printf '%s' "$1" | sha256sum | awk '{print $1}'
}


# ------------------------------------------------------------
# Calcula el hash de un archivo utilizando sus metadatos
#
# %n = nombre
# %s = tamaño
# %a = permisos
# %U = usuario
# %G = grupo
# %Y = timestamp de modificación
# ------------------------------------------------------------
hash_file() {

    local file="$1"

    local metadata

    metadata=$(stat -c '%n|%s|%a|%U|%G|%Y' "$file")

    hash_string "FILE|$metadata"
}


# ------------------------------------------------------------
# Calcula el hash de un directorio
# ------------------------------------------------------------
hash_directory() {

    local directory="$1"

    local name
    name=$(basename "$directory")

    local hashes=()

    # --------------------------------------------------------
    # Obtener los elementos del directorio
    # --------------------------------------------------------

    while IFS= read -r -d '' item; do

        if [ -f "$item" ]; then

            # -------------------------
            # Archivo
            # -------------------------

            hash=$(hash_file "$item")

            hashes+=("$hash")

        elif [ -d "$item" ]; then

            # -------------------------
            # Subdirectorio
            # -------------------------

            hash=$(hash_directory "$item")

            hashes+=("$hash")

        fi

    done < <(
        find "$directory" \
            -mindepth 1 \
            -maxdepth 1 \
            -print0 | sort -z
    )


    # --------------------------------------------------------
    # Construir el árbol de Merkle
    # --------------------------------------------------------

    while [ ${#hashes[@]} -gt 1 ]; do

        local new_hashes=()

        local i=0

        while [ $i -lt ${#hashes[@]} ]; do

            if [ $((i + 1)) -lt ${#hashes[@]} ]; then

                # Hay dos nodos
                combined="${hashes[$i]}${hashes[$((i + 1))]}"

                new_hashes+=(
                    "$(hash_string "$combined")"
                )

            else

                # Nodo sin pareja
                new_hashes+=(
                    "${hashes[$i]}"
                )

            fi

            i=$((i + 2))

        done

        hashes=("${new_hashes[@]}")

    done


    # --------------------------------------------------------
    # Directorio vacío
    # --------------------------------------------------------

    if [ ${#hashes[@]} -eq 0 ]; then

        echo "$(hash_string "DIR|$name|EMPTY")"

    else

        # ----------------------------------------------------
        # El hash del directorio también incluye su nombre
        # ----------------------------------------------------

        echo "$(hash_string "DIR|$name|${hashes[0]}")"

    fi
}


# ============================================================
# Programa principal
# ============================================================

if [ $# -ne 1 ]; then

    echo "Uso:"
    echo "    $0 <directorio>"

    exit 1
fi


directory="$1"


# ------------------------------------------------------------
# Verificar que exista
# ------------------------------------------------------------

if [ ! -d "$directory" ]; then

    echo "Error: '$directory' no es un directorio."

    exit 1
fi


# ------------------------------------------------------------
# Calcular Merkle Root
# ------------------------------------------------------------

root=$(hash_directory "$directory")

echo
echo "Directorio:"
echo "$directory"
echo
echo "Merkle Root:"
echo "$root"
echo
