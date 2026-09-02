CS553 HW1
README.txt
 
Author: Aidan Ash
Date: September 2026
 
1. DIRECTORY STRUCTURE
 
HW1-submission/
 
readme.txt (this file)
hw1-report.pdf (written report with screenshots and answers)
ai-assistance-history.pdf (record of AI assistance used)
 
generate-dataset.sh (Part 3a generates random dataset)
sort-data.sh (Part 3b sorts dataset by column 1)
run-benchmark.sh (Part 3c runs 3a and 3b at 3 scales logs timing)
plot-benchmark.py (Part 3c graphs benchmark results)
benchmark_results.csv (Part 3c raw timing data from run-benchmark.sh)
benchmark_plot.png (Part 3c generated graph output of plot-benchmark.py)
 
2. ENVIRONMENT / REQUIREMENTS
 
Ubuntu Server 26.04 LTS (tested inside Oracle VirtualBox 7.2.16)
bash, all .sh scripts use standard bash and coreutils no external languages needed for 3a or 3b
Python 3 with matplotlib installed for the graphing script only (plot-benchmark.py)
 
To install matplotlib if its not already there:
sudo apt install python3-pip -y
pip3 install matplotlib --break-system-packages
 
All scripts were developed and tested on a 2 core 4GB RAM Ubuntu Server VM. Scripts detect number of avaliable CPU cores at runtime using nproc and parallelize accordingly so they should scale to more or fewer cores on a different machine.
 
3. HOW TO RUN EACH SCRIPT
 
3a. generate-dataset.sh
 
Purpose:
Generates a text file of random records. Each record is one line in the format
<int32> <int32> <100 byte ASCII string>
Uses only built in Linux commands (awk bash) no other programming languages. Runs in parallel across all avaliable CPU cores for speed.
 
Usage:
./generate-dataset.sh <filename> <num_records>
 
Example:
chmod +x generate-dataset.sh
time ./generate-dataset.sh mydata.txt 1000
 
This creates mydata.txt containing 1000 records and prints how long the generation took (via the time command) and the final record count.
 
Notes:
To run in the background so it survives a closed terminal or ssh session (usefull for large record counts) run:
nohup ./generate-dataset.sh mydata.txt 10000000 > gen.log 2>&1 &
disown
Then check progress or completion later with:
cat gen.log
wc -l mydata.txt
 
3b. sort-data.sh
 
Purpose:
Sorts a file produced by generate-dataset.sh numerically by the FIRST COLUMN ONLY not the whole line. Uses GNU sorts parallel option to use multiple cores.
 
Usage:
./sort-data.sh <input_file> [output_file]
 
If output_file is ommitted output defaults to <input_file>.sorted
 
Example:
chmod +x sort-data.sh
time ./sort-data.sh mydata.txt
 
This creates mydata.txt.sorted sorted numerically ascending by the first column and prints how long the sort took.
 
3c. run-benchmark.sh and plot-benchmark.py
 
Purpose:
Automates running generate-dataset.sh and sort-data.sh at three scales (1000, 100000, 10000000 records) records the time taken for each step and writes results to a csv file. The python script then reads that csv and produces a log log graph comparing generate time and sort time across all three scales.
 
Usage:
chmod +x run-benchmark.sh
nohup ./run-benchmark.sh > run-benchmark.log 2>&1 &
disown
 
NOTE the 10000000 record step can take 1-2+ minutes depending on your machine. Running it with nohup/disown like shown above is strongly reccomended so it isnt interupted. Do NOT press Ctrl+C while its running just wait. Check on progress with:
jobs
Once jobs shows nothing (or Done) it has finished.
 
Once complete view the raw timing data:
cat benchmark_results.csv
 
Then generate the graph:
python3 plot-benchmark.py
 
This produces benchmark_plot.png in the same directory showing generate time and sort time (seconds) on a log log scale against number of records so both the low end (1000 records) and high end (10000000 records) are readable on one graph.
 
4. EXAMPLE FULL WORKFLOW (run all of part 3 from scratch)
 
chmod +x generate-dataset.sh sort-data.sh run-benchmark.sh
 
quick individual test
time ./generate-dataset.sh test.txt 1000
time ./sort-data.sh test.txt
 
full benchmark across all 3 scales and graph
nohup ./run-benchmark.sh > run-benchmark.log 2>&1 &
disown
wait for completion check with jobs
cat benchmark_results.csv
python3 plot-benchmark.py
 
5. OTHER NOTES
 
Part 1 (VM setup firewall ssh keys) and Part 2 (Linux command demonstrations) were performed directly on two Ubuntu Server VMs in VirtualBox and are documented with screenshots in hw1-report.pdf. No source code deliverable applies to these sections.
Parts 4 5 and 6 are written conceptual answers included in hw1-report.pdf labeled by question number as required.
Sources used in addition to AI assistance: Linux man pages, Oracle VirtualBox User Guide and White Paper, Ubuntu official documentation.