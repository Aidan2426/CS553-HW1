#!/bin/bash
if [ $# -ne 2 ] ; then 
	echo "Usage: $0 <filename> <num_records>"
	exit 1 
fi

FILENAME="$1"
NUM_RECORDS="$2"
NPROC=$(nproc)
CHUNK=$(( (NUM_RECORDS + NPROC - 1) / NPROC ))
TMPDIR=$(mktemp -d)

gen_chunk(){
	awk -v n="$1" -v seed="$3" '
	BEGIN{
		srand(seed);
		chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		clen = length(chars);
		for(i = 0; i< n; i++){
			int1 = int(rand() * 4294967296);
			int2 = int(rand() * 4294967296);
			str = "";
			for(j = 0; j < 100; j++){
				str = str substr(chars, int(rand() * clen) + 1, 1);

			}
			print int1,int2,str;
	}
	}'>"$2"
}

for i in $(seq 1 $NPROC); do 
	SEEDVAL=$((RANDOM * i + $$))
      	gen_chunk "$CHUNK" "$TMPDIR/part_$i.txt" "$SEEDVAL" &	
done
wait

cat "$TMPDIR"/part_*.txt | head -n "$NUM_RECORDS" > "$FILENAME"
rm -rf "$TMPDIR"

