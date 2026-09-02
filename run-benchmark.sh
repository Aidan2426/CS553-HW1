#!/bin/bash
SCALES="1000 100000 10000000"
RESULTS="benchmark_results.csv"

echo "records,generate_time_sec, sort_time_sec" > "$RESULTS"

for n in $SCALES; do
		FILE="data_${n}.txt"
		SORTED="data_${n}.txt.sorted"

		GEN_START=$(date +%s.%N)
		./generate-dataset.sh "$FILE" "$n"
		GEN_END=$(date +%s.%N)
		GEN_TIME=$(echo "$GEN_END - $GEN_START" | bc)

		SORT_START=$(date +%s.%N)
		./sort-data.sh "$FILE"
		SORT_END=$(date +%s.%N)
		SORT_TIME=$(echo "$SORT_END-$SORT_START" | bc)

		echo "$n,$GEN_TIME,$SORT_TIME" >> "$RESULTS"
		echo "n=$n generate=${GEN_TIME}s sort=${SORT_TIME}s"

	done

echo "Benchmark complete. Results in $RESULTS"


