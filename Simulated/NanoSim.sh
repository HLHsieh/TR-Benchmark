#!/bin/bash 

# Activate NanoSim environment
source activate nanosim

# ---------- Configuration Parameters ----------
prefix=C9ORF72_1                        # Sample
region="chr9"                           # Chromosome/region to simulate
dep=2                                   # Sequencing depth
error=2                                 # Error rate
mean_len="10000"                        # Mean read length for simulation
sd_len=0.1                              # Standard deviation of read length in log scale
align_rate="0.99784"                    # Expected alignment rate from pretrained model
model="/bin/NanoSim/pre-trained_models/human_giab_hg002_sub1M_kitv14_dorado/hg002_nanosim_sub1M" # Path to NanoSim pretrained model (update if required)

# Construct output sequence name
myseq=${prefix}_NanoSim_${dep}x_L${mean_len}_${error}e

# Navigate to the Data directory
cd Data

# ---------- Calculate Required Read Number ----------
genom_size=$(tail -n +2 ${region}.fa | wc -m)

# Calculate the number of reads needed
# Formula: reads = depth * genome_size / mean_length / alignment_rate
read_num=$(echo "$dep * $genom_size / $mean_len / $align_rate" | bc)

# ---------- Run NanoSim ----------
# Use NanoSim to simulate sequencing reads
simulator.py genome -rg ${prefix}.fasta -c $model -t 8 -med $mean_len -sd $sd_len -n $read_num -o $myseq --seed 100 -b guppy

# ---------- Run NanoPlot ----------
# Check the simulated reads meet the required mean read length
NanoPlot -o NanoPlot -p $myseq --fasta ${myseq}_aligned_reads.fasta --tsv_stats --no_static --no_supplementary
cat NanoPlot/${myseq}NanoStats.txt  

# ---------- Calculate Actual Depth ----------
# Extract the total number of bases and calculate sequencing depth
actual_depth=$(grep "number_of_bases" NanoPlot/${myseq}NanoStats.txt | awk -v genom_size="$genom_size" '{print $2 / genom_size}')
echo "Calculated sequencing depth: $actual_depth"
