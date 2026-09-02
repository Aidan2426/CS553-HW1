import csv
import matplotlib.pyplot as plt

records = []
gen_times = []
sort_times = []

with open('benchmark_results.csv') as f:
    reader = csv.DictReader(f)
    for row in reader:
            records.append(int(row['records']))
            gen_times.append(float(row['generate_time_sec']))
            sort_times.append(float(row[' sort_time_sec']))

plt.figure(figsize=(8,6))
plt.plot(records,gen_times,marker='o', label='Generate time')
plt.plot(records, sort_times, marker='s', label='Sort time')
plt.xscale('log')
plt.yscale('log')
plt.xlabel('Number of records')
plt.ylabel('Time(seconds)')
plt.title('Dataset Generation and Sort Time vs Record Count')
plt.legend()
plt.grid(True, which='both', ls='--', alpha=0.5)
plt.tight_layout()
plt.savefig('benchmark_plot.png')
print("Saved plot to benchmark_plot.png")

