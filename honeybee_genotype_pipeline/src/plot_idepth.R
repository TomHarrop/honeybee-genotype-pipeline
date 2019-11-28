#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)

library(data.table)
library(ggplot2)

idepth_file <- args[[1]]

idepth <- fread(idepth_file)

n_indiv <- idepth[, length(unique(INDV))]

gp <- ggplot(idepth, aes(x = MEAN_DEPTH)) +
    ylab("Number of individuals") +
    geom_histogram(bins = n_indiv)
        
ggsave(args[[2]],
       gp,
       device = cairo_pdf,
       width = 10,
       height = 7.5,
       units = "in")

sessionInfo()
