
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
prints the repository description. Below, a sample HTML response is
embedded.

<div style="text-align: center; background-color: rgba(30, 120, 130, 0.1); border-radius: 25px">

``` r
mdt_collection(repo_id = "lsms", org = "wb", raw_html = T)
```

<h2> ID: 3 </h2>
<h2> Repository ID: lsms </h2>
<h2> Title: Living Standards Measurement Study (LSMS) </h2>
<img src="https://microdata.worldbank.org/files/icon-lsms.png"/>
<h2>Short Description</h2>
<p>The LSMS is a research project that was initiated in 1980. It is a response to a perceived need for policy relevant data that would allow policy makers to move beyond simply measuring rates of unemployment, poverty and health care use, for example, to understanding the determinants of these observed social sector outcomes.</p>
<h2>Brief Description</h2>
<div>
<img src="https://microdata.worldbank.org/files/lsms-fp-01.gif">
<h2>Generating relevant data for policy makers and the research community</h2>
&#10;
<p>The <a href="https://www.worldbank.org/en/programs/lsms">Living Standards Measurement Study (LSMS)</a> is a research project  that was initiated in 1980. It is a response to a perceived need for  policy relevant data that would allow policy makers to move beyond simply  measuring rates of unemployment, poverty and health care use, for example, to  understanding the determinants&nbsp;of these observed social sector  outcomes.&nbsp;</p>
<p> The  program is designed to assist policy makers in their efforts to identify how  policies could be designed and improved to positively affect outcomes in health,  education, economic activities, housing and utilities, etc.</p>
<p>The LSMS objectives  are to: </p>
&#10;  improve the quality of  household survey data
  increase the capacity  of statistical institutes to perform household surveys
  improve the ability of  statistical institutes to analyze household survey data for policy needs
  provide policy makers  with data that can be used to understand the determinants of observed social  and economic outcomes
&#10;<p>A more recent initiative funded by the <a href="http://www.gatesfoundation.org/Pages/home.aspx">Bill &amp; Melinda  Gates Foundation (BMGF)</a>, the Living Standards Measurement Study-Integrated Surveys on Agriculture  (LSMS-ISA) project, was launched in 2009. The project supports governments  in Sub-Saharan African countries to generate nationally representative,  household panel data with a strong focus on agriculture and rural development.  The objective of this program is to improve the understanding of development in  Africa, particularly agriculture and linkages between farm and non-farm  activities.</p>
&#10;</div>

</div>

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
| 5908 | WLD_2023_SYNTH-CEN-EN_v01_M | survey | Synthetic Data for an Imaginary Country, Full Population, 2023  | World   | Development Data Group, Data Analytics Unit | open       |       2023 |     2023 |              | NA         | 2023-07-03T23:52:33-04:00 | 2023-07-03T23:52:34-04:00 |        3267 |             223 |       73 |  619 |         1 | <https://microdata.worldbank.org/index.php/catalog/5908> | WLD  |

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

## Study Information

After going through available datasets, you may be interested to know
more about that specific study. Just use `mdt_abstract` to read abstract
directly in your Rstudio.

<div style="text-align: center; background-color: rgba(30, 120, 130, 0.1); border-radius: 25px">

``` r
mdt_abstract(id = 2939, raw_html = T)
```

<ul>
Study id: 
2939
</ul>
<ul>
Study idno: 
MWI_2010-2016_IHPS_v03_M
</ul>
<ul>
Study title: 
Integrated Household Panel Survey 2010-2013-2016 (Long-Term Panel, 102 EAs)
</ul>
<ul>
Study year: 
2016
</ul>
<ul>
Study country: 
Malawi
</ul>
<ul>
Authoring entity: 
National Statistical Office
</ul>
<h2>Abstract</h2>
<p>The 2016 Integrated Household Panel Survey (IHPS) was launched in April 2016 as part of the Malawi Fourth Integrated Household Survey fieldwork operation. The IHPS 2016 targeted 1,989 households that were interviewed in the IHPS 2013 and that could be traced back to half of the 204 enumeration areas that were originally sampled as part of the Third Integrated Household Survey (IHS3) 2010/11. The panel sample expanded each wave through the tracking of split-off individuals and the new households that they formed. Available as part of this project is the IHPS 2016 data as well as the rereleased IHPS 2010 &amp; 2013 data including only the subsample of 102 EAs with updated panel weights. Additionally, the IHPS 2016 was the first survey that received complementary financial and technical support from the Living Standards Measurement Study – Plus (LSMS+) initiative, which has been established with grants from the Umbrella Facility for Gender Equality Trust Fund, the World Bank Trust Fund for Statistical Capacity Building, and the International Fund for Agricultural Development, and is implemented by the World Bank Living Standards Measurement Study (LSMS) team, in collaboration with the World Bank Gender Group and partner national statistical offices. The LSMS+ aims to improve the availability and quality of individual-disaggregated household survey data, and is, at start, a direct response to the World Bank IDA18 commitment to support 6 IDA countries in collecting intra-household, sex-disaggregated household survey data on 1) ownership of and rights to selected physical and financial assets, 2) work and employment, and 3) entrepreneurship – following international best practices in questionnaire design and minimizing the use of proxy respondents while collecting personal information. This dataset is included here.</p>

</div>

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

## <span style="color:blue; text-align: center;">The End!</span>
