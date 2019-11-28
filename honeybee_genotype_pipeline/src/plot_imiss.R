#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

library(data.table)
library(ggplot2)

imiss_file <- args[[1]]

imiss <- fread(imiss_file)

gp <- ggplot(imiss, aes(x = F_MISS)) +
    geom_histogram(binwidth = 0.01)

ggsave(args[[2]],
       gp,
       device = cairo_pdf,
       width = 10,
       height = 7.5,
       units = "in")

sessionInfo()
