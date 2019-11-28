log <- file(snakemake@log[[1]],
            open = "wt")
sink(log, type = "message")
sink(log, type = "output", append = TRUE)

library(data.table)

ldepth_mean_file <- snakemake@input[["stats"]]

ldepth_mean <- fread(ldepth_mean_file)
mean_depth <- ldepth_mean[, mean(MEAN_DEPTH)]

cutoff_table <- data.table(c("min_depth", "max_depth"),
                           c(0.5, 2) * mean_depth)

fwrite(cutoff_table,
       file = snakemake@output[["csv"]],
       col.names = FALSE)

sessionInfo()

