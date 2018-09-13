#suppressMessages(library(ENCODExplorer))
#suppressMessages(library(devtools))
#install_github("ericfournier2/metagene", ref="no_table")
suppressMessages(library(metagene))
suppressMessages(library(GenomicRanges))

#load promoters regions

load("promotors.Rdata")


args = commandArgs(trailingOnly=TRUE)

design_file = args[1]
design = read.delim(design_file, sep=' ', stringsAsFactors = FALSE)

output1 = paste0(args[1],"_", args[2], "cores.RData")
output2 = paste0(args[1],"_",args[2],"cores.tiff")

listbam = as.character(design$File[design$Experiment > 0])

#Don't forget to index bam files!!


mg <- metagene$new(regions = reg, bam_files = listbam, assay = 'chipseq', cores = as.integer(args[2]),
                   force_seqlevels = TRUE, design = design)


save(mg, file = output1)

tiff(filename = output2 , width = 480, height = 480, units ="px")
mg$plot()
dev.off()

