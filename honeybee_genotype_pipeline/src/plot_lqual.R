#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

library(data.table)
library(ggplot2)

qual_file <- args[[1]]

qual <- fread(qual_file)
gp <- ggplot(qual, aes(x = QUAL)) +
  ylab("Number of loci") +
  scale_x_log10() +
  geom_vline(xintercept = 30) +
  geom_histogram(bins = 50)

ggsave(args[[2]],
       gp,
       device = cairo_pdf,
       width = 10,
       height = 7.5,
       units = "in")

sessionInfo()
