
<!-- README.md is generated from README.Rmd. Please edit that file -->

# microData <img src="man/figures/logo.png" align="right" height="138" alt="" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/GutUrago/microData/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/GutUrago/microData/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/GutUrago/microData/branch/master/graph/badge.svg)](https://app.codecov.io/gh/GutUrago/microData?branch=master)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

## What?

I am developing the `microData` R package to search, browse, and extract
metadata from microdata provided by the World Bank (WB), Food and
Agriculture Organization (FAO), International Household Survey (IHSN),
United Nations High Commissioner for Refugees (UNHCR), and International
Labor Organization (ILO) via the NADA API. If you’ve used microdata from
these organizations for your research, you know the pain and time it
takes to understand what all these data and variables mean. If you are
also willing or planning to use micradata, then this is the life-saving
package for you.

## Abstract

The purpose of `microData` is to simplify the process of extracting
complex metadata from data provided by various organizations, thereby
improving data preparation efficiency. At the moment, it supports five
international organizations, namely the World Bank, FAO, UNHCR, IHSN,
and ILO. It has the ability to search, filter, extract, and perform
other tasks that you can do on the web, but it cannot download the data
file itself. This is because, to my knowledge, there is currently no
available documentation for use with the API. Furthermore, this package
has the ability to assist in obtaining the names of variables from a
specific survey, as well as their labels. It also allows you to select
only variables that you are interested in and rename them, while
assigning variable descriptions as label attributes. You can set custom
names and labels for the dataset. Labels play a crucial role when
exporting tables and graphs, as they save you from setting long names in
manuscripts manually. Therefore, this package is available to alleviate
all these difficulties.

<span style="color:orange">**Warning:** Since this package is still
under development, I don’t recommend you use it in reproducible code, as
any changes can happen in the future.</span>

## Installation

You can install the development version of microData from
[GitHub](https://github.com/GutUrago/microData) with:

``` r
# install.packages("devtools")
devtools::install_github("GutUrago/microData")
```

## Collection

All organizations supported by this package use the NADA API to publish
micro-data, which makes use of similar terminologies. Collection simply
means gathering multiple related studies or data sets. To see all
available collections, you can use `mdt_collections` function.

``` r
library(microData)

mdt_collections(org = "wb") |> 
  head() |> 
  kableExtra::kable()
```

|  id | repo_id            | title                                             |
|----:|:-------------------|:--------------------------------------------------|
|  26 | afrobarometer      | Afrobarometer                                     |
|   2 | datafirst          | DataFirst , University of Cape Town, South Africa |
|  22 | dime               | Development Impact Evaluation (DIME)              |
|   1 | microdata_rg       | Development Research Microdata                    |
|   4 | enterprise_surveys | Enterprise Surveys                                |
|  30 | fao                | FAO - Food and Agriculture Microdata Catalog      |

Once you have reviewed all available collections, you may find one that
piques your interest and would like further details. Then,
`mdt_collection` function is there for you. In your HTML viewer, it
prints the repository description.

``` r
mdt_collection(repo_id = "fao", org = "wb", raw_html = T)
```

## Searching

This package gives all flexibility of searching on the web. For more see
the documentation for `mdt_search`.

``` r
mdt_search(keyword = "migration",
           from = 2015,
           to = 2024,
           sort_by = "year",
           sort_order = "desc", 
           results = 3) |> 
  kableExtra::kable()
```

|   id | idno                        | type   | title                                                           | country | authoring_entity                            | form_model | year_start | year_end | repositoryid | repo_title | created                   | changed                   | total_views | total_downloads | varcount | rank | var_found | url                                                      | iso3 |
|-----:|:----------------------------|:-------|:----------------------------------------------------------------|:--------|:--------------------------------------------|:-----------|-----------:|---------:|:-------------|:-----------|:--------------------------|:--------------------------|------------:|----------------:|---------:|-----:|----------:|:---------------------------------------------------------|:-----|
| 5906 | WLD_2023_SYNTH-SVY-EN_v01_M | survey | Synthetic Data for an Imaginary Country, Sample, 2023           | World   | Development Data Group, Data Analytics Unit | open       |       2023 |     2023 |              | NA         | 2023-07-07T12:40:30-04:00 | 2023-07-07T12:40:31-04:00 |        3994 |             272 |       76 |  619 |         1 | <https://microdata.worldbank.org/index.php/catalog/5906> | WLD  |
| 5907 | WLD_2023_SYNTH-SVY-FR_v01_M | survey | Données Synthétiques pour un Pays Imaginaire, Echantillon, 2023 | Monde   | Development Data Group, Data Analytics Unit | open       |       2023 |     2023 |              | NA         | 2023-07-07T12:43:17-04:00 | 2023-07-07T12:43:18-04:00 |        2186 |             176 |       76 |  557 |         1 | <https://microdata.worldbank.org/index.php/catalog/5907> | NA   |
| 5908 | WLD_2023_SYNTH-CEN-EN_v01_M | survey | Synthetic Data for an Imaginary Country, Full Population, 2023  | World   | Development Data Group, Data Analytics Unit | open       |       2023 |     2023 |              | NA         | 2023-07-03T23:52:33-04:00 | 2023-07-03T23:52:34-04:00 |        3265 |             223 |       73 |  619 |         1 | <https://microdata.worldbank.org/index.php/catalog/5908> | WLD  |

There is also handy function to check latest publications of these
datasets.

``` r
mdt_latest(org = "ihsn", limit = 3) |> 
  kableExtra::kable()
```

| id    | idno                | title                                          | country     | created     | changed     | url                                           |
|:------|:--------------------|:-----------------------------------------------|:------------|:------------|:------------|:----------------------------------------------|
| 12189 | SLV_2015_GYTS_v01_M | Global Youth Tobacco Survey 2015               | El Salvador | May-08-2024 | May-08-2024 | <https://datacatalog.ihsn.org//catalog/12189> |
| 12188 | SLV_2013_GSHS_v01_M | Global School-Based Student Health Survey 2013 | El Salvador | May-08-2024 | May-08-2024 | <https://datacatalog.ihsn.org//catalog/12188> |
| 12187 | SLV_2009_GYTS_v01_M | Global Youth Tobacco Survey 2009               | El Salvador | May-08-2024 | May-08-2024 | <https://datacatalog.ihsn.org//catalog/12187> |

You can use `mdt_files` to see the data files included in the study.

``` r
mdt_files(id = 2939) |> 
  head(3) |> 
  kableExtra::kable()
```

|     | id     | sid  | file_id | file_name                               | description                                                                                                    | case_count | var_count |
|:----|:-------|:-----|:--------|:----------------------------------------|:---------------------------------------------------------------------------------------------------------------|:-----------|:----------|
| F1  | 107172 | 2939 | F1      | HouseholdGeovariables_IHS3_Rerelease_10 | Household geographic location (2010 survey)                                                                    | 1619       | 115       |
| F2  | 107173 | 2939 | F2      | PlotGeovariables_IHS3_Rerelease_10      | Plot geographic location (2010 survey)                                                                         | 2392       | 61        |
| F3  | 107143 | 2939 | F3      | hh_mod_a_filt_10                        | Data collected through 2010 Household Questionnaire, Module A: Household Identification (household level data) | 1619       | 59        |

How about variables included in the data file? Of course you can check
them as well.

``` r
mdt_variables(id = 2939, file_id = "F4") |> 
  _[9:15,] |> 
  kableExtra::kable()
```

|     |    uid |  sid | fid | vid  | name      | labl                                 |
|:----|-------:|-----:|:----|:-----|:----------|:-------------------------------------|
| 9   | 770914 | 2939 | F4  | V244 | hh_b03    | Sex                                  |
| 10  | 770915 | 2939 | F4  | V245 | hh_b04    | Relationship to Head                 |
| 11  | 770916 | 2939 | F4  | V246 | hh_b04_os | Relationship to Head (Other Specify) |
| 12  | 770917 | 2939 | F4  | V247 | hh_b05a   | How old is \[NAME\] (years)?         |
| 13  | 770918 | 2939 | F4  | V248 | hh_b05b   | How old is \[NAME} (months)?         |
| 14  | 770919 | 2939 | F4  | V249 | hh_b06a   | When was \[NAME\] born (month)?      |
| 15  | 770920 | 2939 | F4  | V250 | hh_b06b   | When was \[NAME\] born (year)?       |

## Cleaning

Variables in microdata are often named something that has nothing to do
with the variable except question order like this.

|  v1 | v2     | v3  |
|----:|:-------|:----|
|  22 | male   | BE  |
|  23 | female | DE  |
|  24 | male   | BE  |
|  25 | female | DE  |

Then you can prepare another data that contains metadata like this. I
will be explained in detail in vignettes later.

| vars | name    | labs    |
|:-----|:--------|:--------|
| v1   | age     | Age     |
| v2   | gender  | Gender  |
| v3   | country | Country |

You can use `mdt_clean` function to rename and set labels to these
variables.

``` r
cleaned <- mdt_clean(mdt, 
                     metadata,
                     old_name = "vars",
                     new_name = "name",
                     label = "labs")
kableExtra::kable(cleaned)
```

| age | gender | country |
|----:|:-------|:--------|
|  22 | male   | BE      |
|  23 | female | DE      |
|  24 | male   | BE      |
|  25 | female | DE      |

labels are also assigned.

``` r
attr(cleaned$gender, "label")
#> [1] "Gender"
```

More coming soon!

## The End!
