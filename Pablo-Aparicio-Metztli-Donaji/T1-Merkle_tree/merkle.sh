#!/bin/sh
# merkle.sh - calcula la raíz de un árbol de Merkle a partir de los archivos
# dentro de un directorio dado.
#
# Uso: ./merkle.sh [directorio]
#   directorio  ruta al directorio con los archivos "hoja" (por defecto: ./merkle_demo/data)

set -e

DIR="${1:-./merkle_demo/data}"

if [ ! -d "$DIR" ]; then
  echo "El directorio '$DIR' no existe." >&2
  exit 1
fi

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# --- Nivel 0: hash de cada archivo (hojas) ---
LEVEL=0
LEAVES="$TMP/level_$LEVEL.txt"
: > "$LEAVES"

for f in "$DIR"/*; do
  [ -f "$f" ] || continue
  h=$(shasum -a 256 "$f" | awk '{print $1}')
  echo "$h" >> "$LEAVES"
  echo "hoja: $(basename "$f") -> $h"
done

sort -o "$LEAVES" "$LEAVES"   # orden determinista, independiente del filesystem

CURRENT="$LEAVES"
N=$(wc -l < "$CURRENT" | tr -d ' ')

if [ "$N" -eq 0 ]; then
  echo "No hay archivos en '$DIR'." >&2
  exit 1
fi

echo ""
echo "=== construyendo niveles superiores ==="

# --- Niveles superiores: combinar hashes de a pares hasta llegar a la raíz ---
while [ "$N" -gt 1 ]; do
  LEVEL=$((LEVEL + 1))
  NEXT="$TMP/level_$LEVEL.txt"
  : > "$NEXT"

  i=1
  while [ "$i" -le "$N" ]; do
    h1=$(sed -n "${i}p" "$CURRENT")
    j=$((i + 1))
    if [ "$j" -le "$N" ]; then
      h2=$(sed -n "${j}p" "$CURRENT")
    else
      h2="$h1"   # nodo impar: se duplica (misma convención que usa Bitcoin)
    fi
    combined=$(printf '%s%s' "$h1" "$h2" | shasum -a 256 | awk '{print $1}')
    echo "$combined" >> "$NEXT"
    echo "nivel $LEVEL: H($h1 + $h2) = $combined"
    i=$((i + 2))
  done

  CURRENT="$NEXT"
  N=$(wc -l < "$CURRENT" | tr -d ' ')
done

echo ""
echo "=== raíz de Merkle ==="
cat "$CURRENT"
