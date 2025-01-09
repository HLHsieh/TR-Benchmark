# TR-Benchmark

This repository contains the code and relevant results for the article titled: **Comprehensive evaluation of tandem repeat size quantification and genotyping with nanopore sequencing data.**

## Tools

The table below lists the tools included in the benchmarking study, along with their tested versions and the input formats used in this study:

| Tools               | Test version         | Input formats         |
|---------------------|----------------------|----------------------|
| [HMMSTR](https://github.com/Boyle-Lab/HMMSTR) | v1.0.1              | FASTA/FASTQ              |
| [NASTRA](https://github.com/renzilin/NASTRA) | Installed in May 2024 | BAM |
| [LongTR](https://github.com/gymrek-lab/LongTR) | v1.0                | BAM                |
| [NanoRepeat](https://github.com/WGLab/NanoRepeat) | v1.8.1              | BAM              |
| [Straglr](https://github.com/bcgsc/straglr) | v1.5                | BAM                |
| [tandem-genotypes](https://github.com/mcfrith/tandem-genotypes) | v1.9.0              | FASTA/FASTQ              |
| [RepeatHMM](https://github.com/WGLab/RepeatHMM) | v2.0.3              | BAM              |

Click on the tool names to visit their respective GitHub repositories.

## Simulated data

All related files are located under the `Simulated/` folder.

**Step 1: Generate Mock Chromosomes**

Mock chromosomes with varying tandem repeat sizes were generated based on the human reference genome `GRCh38` (See `generate_mock_chromosomes.R`).

**Step 2: Simulate Sequencing Data** 

Simulated sequencing data were generated using [NanoSim]([https://github.com/WGLab/RepeatHMM](https://github.com/bcgsc/NanoSim)) (v3.1.0)(See `NanoSim.sh`), and the resulting `XXX_aligned_reads.fasta` file was used for further analysis.

Details of the simulation settings:

- 2% sequencing error rate: Pretrained model `human_giab_hg002_sub1M_kitv14_dorado` provided by NaonaSim was used.
- 4% sequencing error rate: An in-house trained model was used (`NanoSim_R10_model.tar.gz`).
- 10% sequencing error rate: Pretrained model `human_NA12878_DNA_FAB49712_guppy` provided by NaonaSim was used.

## Public data



## Tandem repeat quantification and genotyping

## Performance evaluation

