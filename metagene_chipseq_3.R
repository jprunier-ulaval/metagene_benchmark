suppressMessages(library(ENCODExplorer))
suppressMessages(library(metagene))
suppressMessages(library(GenomicRanges))

#load promoters regions

load("promotors.Rdata")


args = commandArgs(trailingOnly=TRUE)

################

#2chip_1ctrl.txt
# args[1] == "2chip_1ctrl"
# args[2] == nombre de cores

design_file = args[1]
design = read.delim(design_file, sep=' ', stringsAsFactors = FALSE)

output1 = paste0(args[1], "_", args[2], "cores.RData")
output2 = paste0(args[1],"_",args[2],"cores.tiff")

##################

#experimental design:
#files,exp1,exp2,exp3
#bam1,1,0,0
#bam2,2,2,2
#bam3,0,1,0
#bam4,0,0,0
#bam5,0,1,0
# explication: 1 stands for test, 2 for control


listbam = as.character(design$File[design$Experiment > 0])



#Don't forget to index bam files!!
mg <- metagene$new(regions = reg, bam_files = listbam, assay = 'chipseq', cores = as.integer(args[2]), force_seqlevels = TRUE)


mg$produce_table(design = design)

save(mg, file = output1)

tiff(filename = output2 , width = 480, height = 480, units ="px")
mg$plot()
dev.off()

