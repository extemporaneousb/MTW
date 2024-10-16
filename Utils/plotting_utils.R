
require(tidyverse)
require(Rsamtools)
require(Gviz)
require(biomaRt)
require(BSgenome.Hsapiens.UCSC.hg19)

sname <- "KB-001350-224_S62_L001"
fname <- sprintf("./Results/%s/%s.tsv", sname, sname)
cals <- read.table(
    fname, header = TRUE, stringsAsFactors=FALSE, comment.char = "")
colnames(cals)
colnames(cals) <- gsub("^X..?[0-9]+.", "", colnames(cals), perl=FALSE)

mmm <- cals[,ncol(cals)] %>% strsplit(split=",") %>% lapply(\(x) {
    xis <- as.integer(x)
    sxis <- sum(xis)
        
    v <- if(length(xis) >= 4) {
             xis[1:4]
         } else {
             c(xis, rep(0, 4-length(xis)))
         }
    c(sxis, 100*v/sxis)
})

mmm <- do.call(rbind, mmm)
colnames(mmm) <- c("AD", paste("Freq", 1:4, sep = "_"))
mmm <- cbind(Sample=sname, cals[, c("POS", "DP")], mmm)


mmm[,c("POS", "DP", "AD")] %>% pivot_longer(cols=c("DP", "AD"))  %>%
    ggplot(aes(POS, value, color=name)) + geom_line()

mmm[,c("POS", "Freq_1", "Freq_2")] %>% pivot_longer(cols=c("Freq_1", "Freq_2", "Freq_3", "Freq_4")) %>%
    ggplot(aes(POS, value, color=name)) + geom_bar(stat="identity")

mmm[,c("POS", "AD", "Freq_1")] %>% 
    ggplot(aes(POS, AD)) + geom_line(color="navy") +
    geom_line(aes(POS, (100-Freq_1)/100*mean(AD), color="goldenrod")) + scale_y_sqrt()


    
    
    




m <- lapply(strsplit(cals$, split = ","),
            \(x) 


pivot_longer(
chromosome(Hsapiens)
chromosome(Hsapiens) <- "chrM"

CHR_M_LENGTH <- 16569 - 1

refSeqTrack <- SequenceTrack(Hsapiens, chromosome = "chrM")
geneTrack <- BiomartGeneRegionTrack(genome = "hg19", chromosome = "chrM",
                                    start = 1, end = CHR_M_LENGTH,
                                    stacking = "dense")

alnTrack <- AlignmentsTrack("./Results/KB-001350-224_S62_L001.bam", isPaired=TRUE, genome="HG19",
                            chromosome="chrM", start=1, end=CHR_M_LENGTH,
                            stacking="squish")

plotTracks(list(geneTrack), chromosome = "chrM", from = 1, to = 1500)


