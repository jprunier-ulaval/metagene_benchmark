library(ENCODExplorer)
library(metagene)

#BiocInstaller::biocLite("GenomicRanges") #already installed on the server

library(GenomicRanges)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene

prom <- promoters(genes(txdb), upstream = 1500, downstream = 500)

reg <- prom[seq(1,length(prom),10),]

load("sdfchiptest.RData")

#downloadEncode(sdfchiptest)  #don't need to that again since they have been already downloaded

listbam <- list.files(pattern = ".bam")

load("design.csv")
#experimental design:
#files,exp1,exp2,exp3
#bam1,1,0,0
#bam2,2,2,2
#bam3,0,1,0
#bam4,0,0,0
#bam5,0,1,0
# explication: 1 stands for test, 0 for control

#Don't forget to index bam files!!
mg <- metagene$new(regions = reg, bam_files = listbam, assay = 'chipseq', design = design ,cores = 2,
                   force_seqlevels = TRUE)

tiff(filename = "metagene_plot.tiff", width = 480, height = 480, units ="px")
mg$plot()
dev.off()

