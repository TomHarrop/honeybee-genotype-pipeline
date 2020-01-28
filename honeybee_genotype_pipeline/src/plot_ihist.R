#!/usr/bin/env Rscript

log <- file(snakemake@log[[1]],
            open = "wt")
sink(log, type = "message")
sink(log, type = "output", append = TRUE)

library(data.table)
library(ggplot2)

ReadIhist <- function(ihist_file){
    fread(ihist_file, skip = 5)[`#InsertSize` <= 1000]
}

CalculateMeanInsert <- function(ihist_dt){
    my_rle <- ihist_dt[, structure(
        list(lengths = Count, values = `#InsertSize`), class = "rle")]
    my_mean <- mean(inverse.rle(my_rle))
    as.integer(round(my_mean, 0))
}

# read files
ihist_files <- snakemake@input[["ihist_files"]]
names(ihist_files) <- sub(".ihist", "", basename(ihist_files))

# combine
ihist_list <- lapply(ihist_files, ReadIhist)
ihist_data <- rbindlist(ihist_list, idcol = "sample")

# mean per sample
mean_dt <- ihist_data[, .(meansize = CalculateMeanInsert(.SD)),
                      by = sample]

# configure plot
y_pos <- ihist_data[, max(Count)]
vd <- viridisLite::viridis(3)

# plot
gp <- ggplot(ihist_data,
       aes(x = `#InsertSize`, y = Count)) + 
    facet_wrap(~ sample) + 
    xlab("Mapped insert size") + 
    geom_vline(mapping = aes(xintercept = meansize),
               data = mean_dt,
               linetype = 2,
               colour = vd[[2]])+
    geom_text(mapping = aes(x = meansize + 10,
                            y = y_pos,
                            label = meansize),
              hjust = "inward",
              colour = vd[[2]],
              data = mean_dt) +
    geom_area(fill = alpha(vd[[1]], 0.5))

ggsave(snakemake@output[["plot"]],
       gp,
       device = cairo_pdf,
       width = 10,
       height = 7.5,
       units = "in")

sessionInfo()
