#!/bin/bash
if [ $# -lt 1 ]; then
	ech "Usage: $0 <input_file> [output_file]"
	exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="${2:-${INPUT_FILE}.sorted}"
NPROC=$(nproc)

sort -n -k1,1 --parallel=$NPROC -S 50% "$INPUT_FILE" > "$OUTPUT_FILE"
echo "Sorted $INPUT_FILE -> $OUTPUT_FILE"
