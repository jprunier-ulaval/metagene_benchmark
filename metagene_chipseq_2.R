library(ENCODExplorer)
library(metagene)
library(GenomicRanges)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

prom <- promoters(genes(txdb), upstream = 1500, downstream = 1500)

reg <- prom[seq(1,length(prom),10),]

#load("sdfchiptest.RData")

args = commandArgs(trailingOnly=TRUE)

################

#2chip_1ctrl.txt
# args[1] == "2chip_1ctrl"
# args[2] == nombre de cores

design_file = paste0(args[1], ".txt")
design = read.delim(design_file, sep=' ', stringsAsFactors = FALSE)

output1 = paste0(args[1], "_", args[2], "cores.RData")
output2 = paste0(args[1],"_",args[2],".tiff")

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
mg <- metagene$new(regions = reg, bam_files = listbam, assay = 'chipseq', cores = as.integer(args[2]),
                   force_seqlevels = TRUE)


#mg$produce_table(design = design)

save(mg, file = output1)

tiff(filename = output2 , width = 480, height = 480, units ="px")
mg$plot()
dev.off()

