# easyVP

### What is easyVP

**easyVP** lets you create annotated volcano plots with colored dots

# Installation

The package can be installed with

```r
install_github("nahtan/easyVP")
```

After installation, the package can be loaded into R.

    library(easyVP)

# Using easyVP

The main function in the **easyVP** package is `easyVP()`.

See example below.

# Parameters

@param DEGlist limma output. List of differentially expressed features with mandatory columns: logFC, P.Value, adj.P.Val, GeneID

@param main a title for your plot.

@param FCcol1 a first logFC threshold for key color.

@param FCcol2 a second logFC threshold for key color.

@param FCcol3 a third logFC threshold for key color.

@param FClimit a logFC threshold beyond which dots are annotated with GeneID.

@param PVALlimit a -log10(P.Value) threshold beyond which dots are annotated with GeneID. Must be -log10(P.Value) and notP.Value or adj.P.Val.

@param LegendPlace a place to choose for legend between "topleft", "topright", "bottomright", "bottomleft".


# Example
```r
MyDEGs <- read.csv2(file="~/MyStudy/MyDEGs.csv", header=T, sep=";",dec=".", row.names=1)
colnames(MyDEGs)[1] <-"logFC"
colnames(MyDEGs)[4] <-"P.Value"
colnames(MyDEGs)[5] <-"adj.P.Val"
colnames(MyDEGs)[8] <-"GeneID"
easyVP(DEGlist=MyDEGs,main="My easy VP", FCcol1=0.5, FCcol2=1, FCcol3=2, FClimit=2, PVALlimit=5, LegendPlace="topright")
```
