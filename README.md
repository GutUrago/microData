
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

I am developing the `microData` package to search, browse, and extract
metadata from microdata provided by the World Bank (WB), Food and
Agriculture Organization (FAO), International Household Survey (IHSN),
United Nations High Commissioner for Refugees (UNHCR), and International
Labor Organization (ILO) via the NADA API. Any researcher who has used
microdata from these organizations knows how difficult and
time-consuming it is to understand and import these data and variables
into R. If you are a user or plan to use micradata, then this is the
life-saving R package for you.

## Abstract

The purpose of `microData` is to simplify the process of extracting
complex metadata from data provided by various organizations, thereby
improving data preparation efficiency. At the moment, it supports five
international organizations, namely the World Bank, FAO, UNHCR, IHSN,
and ILO. It has the ability to search, filter, extract, and perform
other tasks that you can do on the web, but it cannot download the data
file itself. This is because, to my knowledge, there is currently no
available documentation for use with the API. I think it is due to data
license issue because there are few accessible datasets through the API.
Furthermore, this package has the ability to assist in obtaining the
names of variables from a specific survey, as well as their labels. It
also allows you to select only variables that you are interested in and
rename them, while assigning variable descriptions as label attributes.
You can set custom names and labels for the dataset. Labels play a
crucial role when exporting tables and graphs, as they save you from
setting long names in manuscripts manually. Therefore, this package is
available to alleviate all these difficulties.

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
available collections, you can use `collections()` function.

``` r
library(microData)

collections(org = "wb") |> 
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

## Searching

This package gives all flexibility of searching on the web. For more see
the documentation for `search_catalog()`.

``` r
search_catalog(
  keyword = "food",
  org = "unhcr",
  from = 2015,
  to = 2024,
  country ="Ethiopia",
  sort_by = "year",
  sort_order = "desc", 
  results = 3) |> 
  kableExtra::kable()
```

| idno                     | formid | title                                                                                                                          | country  | authoring_entity                                                | form_model | year_start | year_end | repositoryid | repo_title              | created                   | changed                   | varcount | total_views | total_downloads |      rank | type   |   id | var_found | url                                                  | iso3 |
|:-------------------------|-------:|:-------------------------------------------------------------------------------------------------------------------------------|:---------|:----------------------------------------------------------------|:-----------|-----------:|---------:|:-------------|:------------------------|:--------------------------|:--------------------------|---------:|------------:|----------------:|----------:|:-------|-----:|----------:|:-----------------------------------------------------|:-----|
| UNHCR_ETH_2023_IKEA_v2.1 |      3 | Baseline-Endline Panel Survey of Refugee Cooperative Members in UNHCR Sub-office Operational Area of Melkadida, Ethiopia, 2023 | Ethiopia | UNHCR                                                           | licensed   |       2023 |     2023 | EHA          | East and Horn of Africa | 2023-10-17T15:25:32+00:00 | 2024-05-30T11:36:57+00:00 |      287 |        2576 |               0 | 0.7350542 | survey | 1021 |        12 | <https://microdata.unhcr.org/index.php/catalog/1021> | ETH  |
| WBG_ETH_2020_HFPSR_v01_M |      5 | Monitoring COVID-19 Impact on Refugees in Ethiopia: High-Frequency Phone Survey of Refugees 2020                               | Ethiopia | World Bank-UNHCR Joint Data Center on Forced Displacement (JDC) | remote     |       2020 |     2020 | EHA          | East and Horn of Africa | 2022-07-05T11:29:36+00:00 | 2022-07-05T11:29:53+00:00 |      392 |        3413 |               0 | 0.3820789 | survey |  704 |        19 | <https://microdata.unhcr.org/index.php/catalog/704>  | ETH  |
| UNHCR_ETH_SENS_2018_v2.1 |      3 | Standardized Expanded Nutrition Survey (SENS) in Melkadida Refugee Camps - 2018                                                | Ethiopia | UNHCR                                                           | licensed   |       2018 |     2018 | EHA          | East and Horn of Africa | 2019-07-15T13:21:23+00:00 | 2019-12-05T13:38:14+00:00 |      105 |        4480 |             212 | 0.6680453 | survey |  114 |         8 | <https://microdata.unhcr.org/index.php/catalog/114>  | ETH  |

There is also handy function to check latest publications of these
datasets.

``` r
latest_entries(org = "wb", limit = 3) |> 
  kableExtra::kable()
```

|   id | idno                            | title                                                                                    | country       | created     | changed     | url                                                      |
|-----:|:--------------------------------|:-----------------------------------------------------------------------------------------|:--------------|:------------|:------------|:---------------------------------------------------------|
| 6269 | CIV_2021_PEJEDEC-AFL_v01_M      | Youth Employment and Skills Development Project - Apprenticeship Firm Listing 2021       | Côte d’Ivoire | Jul-24-2024 | Jul-24-2024 | <https://microdata.worldbank.org/index.php/catalog/6269> |
| 6268 | CIV_2014-2016_PEJEDEC-AFS_v01_M | Youth Employment and Skills Development Project - Apprenticeship Firms Surveys 2014-2016 | Côte d’Ivoire | Jul-24-2024 | Jul-24-2024 | <https://microdata.worldbank.org/index.php/catalog/6268> |
| 6267 | CIV_2014-2018_PEJEDEC-AYS_v01_M | Youth Employment and Skills Development Project - Apprenticeship Youth Surveys 2014-2018 | Côte d’Ivoire | Jul-24-2024 | Jul-24-2024 | <https://microdata.worldbank.org/index.php/catalog/6267> |

You can use `data_files` to see the data files included in the study.
Let’s see one of the popular survey on the WB. We can also use id number
of the study, which is 3110 instead of the name (See next code chunk).

``` r
data_files(id = "IND_2015_DHS_v01_M_v02_A_IPUMS", org = "wb") |> 
  kableExtra::kable()
```

|     | id     | sid  | file_id | file_name     | description              | case_count | var_count |
|:----|:-------|:-----|:--------|:--------------|:-------------------------|:-----------|:----------|
| B   | 114450 | 3110 | B       | IND2015-B.dat | Birth records            | 1315617    | NULL      |
| C   | 114451 | 3110 | C       | IND2015-C.dat | Child records            | 259627     | NULL      |
| H   | 114453 | 3110 | H       | IND2015-H.dat | Household member records | 2869043    | NULL      |
| M   | 114452 | 3110 | M       | IND2015-M.dat | Man records              | 112122     | NULL      |
| W   | 114449 | 3110 | W       | IND2015-W.dat | Woman records            | 699686     | NULL      |

How about variables included in the data file? Of course you can check
them as well.

``` r
variables(id = 3110, file_id = "W") |> 
  head() |> 
  kableExtra::kable()
```

|     uid |  sid | fid | vid         | name        | labl                                      |
|--------:|-----:|:----|:------------|:------------|:------------------------------------------|
| 2609913 | 3110 | W   | W_SAMPLE    | W_SAMPLE    | IPUMS-DHS sample identifier               |
| 2609914 | 3110 | W   | W_SAMPLESTR | W_SAMPLESTR | IPUMS-DHS sample identifier (string)      |
| 2609915 | 3110 | W   | W_COUNTRY   | W_COUNTRY   | Country                                   |
| 2609916 | 3110 | W   | W_YEAR      | W_YEAR      | Year of sample                            |
| 2609917 | 3110 | W   | W_IDHSPID   | W_IDHSPID   | Unique cross-sample respondent identifier |
| 2609918 | 3110 | W   | W_IDHSHID   | W_IDHSHID   | Unique cross-sample household identifier  |

## Setting Attributes

Variables in microdata are often named something that has nothing to do
with the variable except question order like this.

|  v1 | v2     | v3  |
|----:|:-------|:----|
|  22 | male   | BE  |
|  23 | female | DE  |
|  24 | male   | BE  |
|  25 | female | DE  |

Then you can prepare another data that contains metadata like this. It
will be explained in detail in vignettes later.

| vars | name    | labs    |
|:-----|:--------|:--------|
| v1   | age     | Age     |
| v2   | gender  | Gender  |
| v3   | country | Country |

You can use `set_attributes` function to rename and set labels to these
variables.

``` r
my_data <- set_attributes(
  mdt, 
  metadata,
  old_name = "vars",
  new_name = "name",
  label = "labs")
kableExtra::kable(my_data)
```

| age | gender | country |
|----:|:-------|:--------|
|  22 | male   | BE      |
|  23 | female | DE      |
|  24 | male   | BE      |
|  25 | female | DE      |

labels are also assigned.

``` r
str(my_data)
#> 'data.frame':    4 obs. of  3 variables:
#>  $ age    : int  22 23 24 25
#>   ..- attr(*, "label")= chr "Age"
#>  $ gender : chr  "male" "female" "male" "female"
#>   ..- attr(*, "label")= chr "Gender"
#>  $ country: chr  "BE" "DE" "BE" "DE"
#>   ..- attr(*, "label")= chr "Country"
```

More coming soon!
