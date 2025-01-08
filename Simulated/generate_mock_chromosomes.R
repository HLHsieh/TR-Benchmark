######### Load library #########
library("Biostrings")
library("rtracklayer")
library("ggplot2")
library("tidyverse")
library("dplyr")
library("readxl")

######### Create mock chromosome #########

###### C9ORF72 ######
chr9.fa <- readDNAStringSet("Data/chr9.fa")
random_numbers <- c(16, 181, 835, 2367, 3566, 6464, 3, 264, 498, 1547, 10297, 15630)

# Location of C9ORF72 in chromosome 9
C9ORF72_location <- 27573529
C9ORF72_location_end <- C9ORF72_location + 6*3-1 # Three TR repeats in reference genome

# Initialize empty holders 
original_string <- "GGCCCC" # TR motif
repeated_string_control <- c()
C9ORF72_holder <- c()

# Generate mock genome for C9ORF72
for (i in seq(length(random_numbers))){
  # Repeat the original string according to random_numbers[i]
  repeated_string_control[i] <- paste(rep(original_string, times = random_numbers[i]), collapse = "")
  
  # Insert the repeated string into the genome
  C9ORF72_holder[i] <- paste0(substr(chr9.fa$chr9, 1, C9ORF72_location-1), repeated_string_control[i], 
                              substr(chr9.fa$chr9, C9ORF72_location_end+1, nchar(chr9.fa$chr9)))
  # Save as a FASTA file
  seq_id <- paste0(">C9ORF72_", i)
  file_name <- paste0("Data/", "C9ORF72_", i, ".fasta")
  write(paste(seq_id, "\n", C9ORF72_holder[i], "\n", sep = ""), file = file_name)
}

###### DRD4 ######
# Read chromosome 11 sequence
chr11.fa <- readDNAStringSet("Data/chr11.fa")
random_numbers <- c(8, 37, 140, 400, 545, 925, 2, 17, 94, 228, 1331, 1725)

# Location of DRD4 in chromosome 11
DRD4_location <- 639993
DRD4_location_end <- DRD4_location + 48*4-1 # Four TR repeats in reference genome

# Read DRD4 motifs
DRD4_seq <- read_csv("Data/DRD4_motif.csv", col_names = FALSE)
DRD4_variants <- apply(DRD4_seq, 1, paste0, collapse="")

# Generate random variants for DRD4
random_numbers_variants <- list()
for (i in seq(length(random_numbers))) {
  set.seed(99+i) 
  random_numbers_variants[[i]] <- sample(seq(length(DRD4_variants)), random_numbers[i], replace = TRUE)
}

# Initialize empty holders
repeated_string_control <- c()
DRD4_holder <- c()

# Generate mock genome for DRD4
for (i in seq(length(random_numbers))){
  repeated_string <- character()
  
  # Combine DRD4 variants according to random_numbers_variants
  for (j in seq(length(random_numbers_variants[[i]]))){
    idx <- random_numbers_variants[[i]][j]
    repeated_string <- paste0(repeated_string, DRD4_variants[idx])
  }
  repeated_string_control[i] <- repeated_string
  
  # Insert the repeated string into the genome
  DRD4_holder[i] <- paste0(substr(chr11.fa$chr11, 1, DRD4_location-1), repeated_string_control[i], 
                           substr(chr11.fa$chr11, DRD4_location_end+1, nchar(chr11.fa$chr11)))
  
  # Save as a FASTA file
  seq_id <- paste0(">DRD4_", i)
  file_name <- paste0("Data/", "DRD4_", i, ".fasta")
  write(paste(seq_id, "\n", DRD4_holder[i], "\n", sep = ""), file = file_name)
}

###### D4Z4 ######
# Read chromosome 4 sequence
chr4.fa <- readDNAStringSet("Data/chr4.fa")
random_numbers <- c(1, 5, 10, 22, 41, 88, 2, 4, 17, 30, 69, 98)

# Location of D4Z4 in chromosome 4
D4Z4_location <- 190066141
D4Z4_location_end <- 190092505 - 1

# Read D4Z4 motifs
D4Z4_seq <- read_csv("Data/D4Z4_motif.csv", col_names = FALSE)
D4Z4_variants <- apply(D4Z4_seq, 1, paste0, collapse="")

# Generate random variants for D4Z4
random_numbers_variants <- list()
for (i in seq(length(random_numbers))) {
  set.seed(99+i) 
  random_numbers_variants[[i]] <- sample(seq(length(D4Z4_variants)), random_numbers[i], replace = TRUE)
}

# Initialize empty holders
repeated_string_control <- c()
D4Z4_holder <- c()

# Generate mock genome for D4Z4
for (i in seq(length(random_numbers))){
  repeated_string <- character()
  
  # Combine D4Z4 variants according to random_numbers_variants
  for (j in seq(length(random_numbers_variants[[i]]))){
    idx <- random_numbers_variants[[i]][j]
    repeated_string <- paste0(repeated_string, D4Z4_variants[idx])
  }
  repeated_string_control[i] <- repeated_string
  
  # Insert the repeated string into the genome
  D4Z4_holder[i] <- paste0(substr(chr4.fa$chr4, 1, D4Z4_location-1), repeated_string_control[i], 
                           substr(chr4.fa$chr4, D4Z4_location_end+1, nchar(chr4.fa$chr4)))
  # Save as a FASTA file
  seq_id <- paste0(">D4Z4_", i)
  file_name <- paste0("Data/", "D4Z4_", i, ".fasta")
  write(paste(seq_id, "\n", D4Z4_holder[i], "\n", sep = ""), file = file_name)
}
