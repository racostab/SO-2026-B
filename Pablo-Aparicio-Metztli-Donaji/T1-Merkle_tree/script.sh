#!/bin/sh
# setup.sh - crea una estructura simple de carpetas y archivos de ejemplo
# para probar el cálculo de un árbol de Merkle.

set -e

BASE="merkle_demo"

mkdir -p "$BASE/data"

echo "contenido del bloque 1" > "$BASE/data/block1.txt"
echo "contenido del bloque 2" > "$BASE/data/block2.txt"
echo "contenido del bloque 3" > "$BASE/data/block3.txt"
echo "contenido del bloque 4" > "$BASE/data/block4.txt"

echo "Estructura creada:"
find "$BASE" -type f
