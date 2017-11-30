#' easyVP
#'
#' Create annotated volcano plots with colored dots
#' @param DEGlist limma output. List of differentially expressed features with mandatory columns: logFC, P.Value, adj.P.Val, GeneID
#' @param main a title for your plot.
#' @param FCcol1 a first logFC threshold for key color.
#' @param FCcol2 a second logFC threshold for key color.
#' @param FCcol3 a third logFC threshold for key color.
#' @param FClimit a logFC threshold beyond which dots are annotated with GeneID.
#' @param PVALlimit a -log10(P.Value) threshold beyond which dots are annotated with GeneID. Must be -log10(P.Value) and notP.Value or adj.P.Val.
#' @param LegendPlace a place to choose for legend between "topleft", "topright", "bottomright", "bottomleft".
#' @keywords 
#' @export
#' @examples
#' MyDEGs <- read.csv2(file="~/MyStudy/MyDEGs.csv", header=T, sep=";",dec=".", row.names=1)
#' colnames(MyDEGs)[1] <-"logFC"
#' colnames(MyDEGs)[4] <-"P.Value"
#' colnames(MyDEGs)[5] <-"adj.P.Val"
#' colnames(MyDEGs)[8] <-"GeneID"
#' easyVP(DEGlist=MyDEGs,main="My easy VP", FCcol1=0.5, FCcol2=1, FCcol3=2, FClimit=2, PVALlimit=5, LegendPlace="topright")

easyVP <- function(DEGlist,main,FCcol1,FCcol2,FCcol3,FClimit,PVALlimit,LegendPlace){
  with(DEGlist, plot(logFC, -log10(P.Value), pch=20, cex=.5,main=main, xlab="logFC"))
  with(subset(DEGlist, abs(logFC)>0 & P.Value<0.05), points(logFC, -log10(P.Value), pch=20, cex=.5, col="darkred"))
  with(subset(DEGlist, abs(logFC)>FCcol1 & P.Value<0.05), points(logFC, -log10(P.Value), pch=20, cex=.5, col="darkorange"))
  with(subset(DEGlist, abs(logFC)>FCcol2 & P.Value<0.05), points(logFC, -log10(P.Value), pch=20, cex=.5, col="darkgreen"))
  with(subset(DEGlist, abs(logFC)>FCcol3 & P.Value<0.05), points(logFC, -log10(P.Value), pch=20, cex=.5, col="green"))
  with(subset(DEGlist, P.Value>0.05), points(logFC, -log10(P.Value), pch=20, cex=.5, col="grey"))
  library(calibrate)
  with(subset(DEGlist, abs(logFC)>FClimit & P.Value<0.05), textxy(logFC, -log10(P.Value), labs=GeneID, cex=.5))
  with(subset(DEGlist, abs(logFC)>0 & -log10(P.Value)>PVALlimit), textxy(logFC, -log10(P.Value), labs=GeneID, cex=.5))
  legend(LegendPlace,legend=c(paste("|logFC|>",FCcol3,sep=""),paste("|logFC|<",FCcol3,sep=""),paste("|logFC|<",FCcol2,sep=""),paste("|logFC|<",FCcol1,sep=""),"pval>0.05"), fill=c("green","darkgreen","darkorange","darkred","grey"),cex=0.7, border=F, bty="n")
  abline(h=-log10(0.05), col="red")
  abline(h=-log10(max(DEGlist$P.Value[which(DEGlist$adj.P.Val<0.05)])), col="red")
  }