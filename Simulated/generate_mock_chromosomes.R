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

# loction of C9ORF72
C9ORF72_location <- 27573529
C9ORF72_location_end <- C9ORF72_location + 6*3-1 # three TR repeats in reference genome

# insert to genome 
original_string <- "GGCCCC"
repeated_string_control <- c()
C9ORF72_holder <- c()

for (i in seq(length(random_numbers))){
  
  repeated_string_control[i] <- paste(rep(original_string, times = random_numbers[i]), collapse = "")
  
  C9ORF72_holder[i] <- paste0(substr(chr9.fa$chr9, 1, C9ORF72_location-1), repeated_string_control[i], 
                              substr(chr9.fa$chr9, C9ORF72_location_end+1, nchar(chr9.fa$chr9)))
  # save as fasta file
  seq_id <- paste0(">C9ORF72_", i)
  file_name <- paste0("Data/", "C9ORF72_", i, ".fasta")
  write(paste(seq_id, "\n", C9ORF72_holder[i], "\n", sep = ""), file = file_name)
}

