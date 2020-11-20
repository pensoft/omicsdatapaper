
<!-- README.md is generated from README.Rmd. Please edit that file -->

# omicsdatapaper

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

This golem is an installable version of the Omics Data Paper R shiny
app: <https://mdmtrv.shinyapps.io/Omics_data_paper/>

The  Omics Data Paper R Shiny app demonstrates a workflow for automatic import of [ENA](https://www.ebi.ac.uk/ena/browser/home) genomic metadata into an [omics data paper manuscript](https://blog.pensoft.net/tag/omics-data-paper/). Streamlined conversion of metadata into manuscript facilitates authoring of omics data papers, which allow omics dataset creators to receive credit for their work and to improve the description and visibility of their datasets. 

A production-grade version of the workflow has been integrated inside Pensoft's [ARPHA Writing Tool (AWT)](https://arpha.pensoft.net/).  You can read more about it in this
[abstract](https://biss.pensoft.net/article/59041/) and
[blogpost](https://blog.pensoft.net/2020/06/16/streamlined-import-of-omics-metadata-from-the-european-nucleotide-archive-ena-into-an-omics-data-paper-manuscript/) or head over to the [AWT](https://arpha.pensoft.net/) to create a manuscript.


## Requirements

You need R and R Studio to run this app. We’ve tested it with the
following versions of R and RStudio:

  - R 3.0.1+
  - RStudio Desktop 1.3.1093

## Installation

You can install the latest version of omicsdatapaper from
[github](https://github.com/) with:

``` r
devtools::install_github("mdmtrv/omicsdatapaper")
```

## Use

The omicsdatapaper golem has only one function: to run the Omics Data
Paper Generator app locally on your machine. This is how to do it:

``` r
library(omicsdatapaper)
run_app()
```

That’s all\! The package handles all dependencies and imports the
required
[jats-skeleton.xml](https://github.com/pensoft/omics-data-paper-shinyapp/blob/master/jats-skeleton.xml).
