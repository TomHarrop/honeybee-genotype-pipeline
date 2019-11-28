#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

library(data.table)
library(ggplot2)

ldepth_mean_file <- args[[1]]

ldepth_mean <- fread(ldepth_mean_file)

mean_depth <- ldepth_mean[, mean(MEAN_DEPTH)]

gp <- ggplot(ldepth_mean, aes(x = MEAN_DEPTH)) +
    ylab("Number of loci") +
    scale_x_log10() +
    geom_histogram(bins = 100) +
    geom_vline(xintercept = c(0.5, 2) * mean_depth)

ggsave(args[[2]],
       gp,
       device = cairo_pdf,
       width = 10,
       height = 7.5,
       units = "in")

sessionInfo()
