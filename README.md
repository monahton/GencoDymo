# GencoDymo
----

<!-- badges start -->
[![DOI](https://zenodo.org/badge/231610595.svg)](https://zenodo.org/badge/latestdoi/231610595)
[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Licence](https://img.shields.io/badge/licence-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)
[![R build
status](https://github.com/m-jahn/lattice-tools/workflows/R-CMD-check/badge.svg)](https://github.com/m-jahn/fluctuator/actions)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/monahton)
![GitHub issues](https://img.shields.io/github/issues/monahton/GencoDymo)
![GitHub last
commit](https://img.shields.io/github/last-commit/monahton/GencoDymo)
![Platform](https://img.shields.io/badge/platform-all-green)

[![Last-changedate](https://img.shields.io/badge/last%20change-2021--11--21-yellowgreen.svg)](/commits/master)

<!-- badges end -->
----
## Data Extraction and Manipulation from the GENCODE Database

## Introduction

Gene annotations for the human genome has been made available by several databases integrating data from systematic explorations of different experimental and computational resources. The GENCODE project [1], part of the ENCODE project [2], offers accurate annotations of the human and mouse genomes from the literature, primary data repositories, computational predictions, manual annotation, and experimental validation of genes and transcripts including the noncoding transcripts which are continously discovered and annotated. GENCODE is by large one of the most comprehensive and standardized database for gene annotations that is widely used by the community. 
The gene sets are comprehensive and include protein-coding and non-coding loci including alternatively spliced isoforms and pseudogenes. GENCODE gene annotations are constantly updated and regularly released as the Ensembl/GENCODE gene sets which are accessible via their official website https://www.gencodegenes.org. GencoDymo is an R package that interrogates different releases of GENCODE annotations from the human and the mouse genomes. GencoDymo extracts and manipulates GENCODE annotations and provides easily-accessible data regarding annotations statistics, releases comparison, in addition to introns and splice sites data. Moreover, GencoDymo can produce fasta files of donor and acceptor splice sites motifs that can be directly uploaded to the MaxEntScan tool [3] for the calculation of splice sites scores.

1. Frankish A, Diekhans M, Ferreira AM, Johnson R, Jungreis I, Loveland J et al. “GENCODE reference annotation for the human and mouse genomes”. Nucleic Acids Res. 2019. 47: D766–773. doi:10.1093/nar/gky955.
2. Harrow J, Denoeud F, Frankish A, Reymond A, Chen CK,
Chrast J et al. "GENCODE: producing a reference annotation for ENCODE".
Genome Biol. 2006. 7 Suppl 1:S4.1-9. doi:10.1186/gb-2006-7-s1-s4.
3. Yeo G and Burge CB. “Maximum entropy modeling of short sequence motifs with applications to RNA splicing signals”. J Comput Biol. 2004. 11:377-394. doi:10.1089/1066527041410418.

## Installation

R-package GencoDymo can be installed:

    library(devtools)
    install_github("monahton/GencoDymo")

After installation, the package can be loaded into R.

    library(GencoDymo)

## Usage

For details of how to use this package, please see the vignette.
In case of problems in installing or using the package, open an issue or send an email to <monah.aboualezz@igm.cnr.it>

## Citation

Please cite the usage of GencoDymo R-package as follows:

Abou Alezz M, Salviati L, Alfieri R, Bione S., GencoDymo: Data Extraction and Manipulation from the GENCODE Database. (2020). R-package version 0.2.1, https://github.com/monahton/GencoDymo, DOI: 10.5281/zenodo.3605995


## Development

If you would like to contribute, please submit a pull request!
If you have any suggestions for features, please contact Monah Abou Alezz (monah.aboualezz@igm.cnr.it).

## Dependencies

GencoDymo requires [dplyr](https://dplyr.tidyverse.org/) to be previously installed.

**Package**: GencoDymo

**Type**: Package

**Title**: Data Extraction and Manipulation from the GENCODE Database

**Version**: 0.5.1

**Date**: 2020-10-20

**Author**: Monah Abou Alezz

**Maintainer**: Monah Abou Alezz <monah.aboualezz@igm.cnr.it>

