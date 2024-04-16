
<!-- README.md is generated from README.Rmd. Please edit that file -->

# microData

<!-- badges: start -->
<!-- badges: end -->

The goal of microData is to assist the process of obtaining complex
metadata of datasets provided by different organizations. At the moment,
it supports four organizations, namely, World bank, FAO, UNHCR and IHSN.
It can extract the names of available surveys along with their necessary
metadata. Moreover, it has an ability to assist obtaining the names of
variables from specific survey along with their labels. It enables you
to select only variables that you are interested in and rename them
while assigning variable descriptions as their label attributes. For
this process to happen, you must have an excel installed on your local
machine.

## Installation

You can install the development version of microData from
[GitHub](https://github.com/GutUrago/microData) with:

``` r
# install.packages("devtools")
devtools::install_github("GutUrago/microData")
```

## Surveys

This package helps you to see all available surveys published by
specific organization. In addition it returns a data table with four
columns. The first column is a country where the survey is collected,
second column is the year, third column is the catalog number of the
survey and last column is the title of the survey. Out of these details
catalog number is used as a unique identifier of the survey throughout
the data extraction process.

``` r
library(microData)
sv <- surveys(org = "unhcr")
sv |> head() |> kableExtra::kable()
```

| Country     | Year | Catalog | Survey                                                                                                              |
|:------------|:-----|:--------|:--------------------------------------------------------------------------------------------------------------------|
| Afghanistan | 2022 | 1000    | Humanitarian Situation Monitoring Round 1, 2022                                                                     |
| Djibouti    | 2020 | 397     | COVID-19 National Panel Phone Survey 2020, Wave 1                                                                   |
| Lebanon     | 2020 | 243     | Monitoring of the Effects of Economic Deterioration on Refugee Households, Wave 1 (RON) 2020                        |
| Lebanon     | 2020 | 239     | Monitoring of the Effects of Economic Deterioration on Refugee Households, Wave 1 (SYR) 2020                        |
| Thailand    | 2020 | 523     | Multi-sector Rapid Needs Assessment and Post-Distribution Monitoring of Cash-Based Intervention - Round 1, May 2020 |
| South Sudan | 2015 | 504     | High Frequency Survey 2015, Wave 1                                                                                  |

## Metadata

You can extract all details of provided files by an organization.
Sometimes these surveys are from external organizations. In that case
microData cannot extract its metadata. But it still gives a hint what to
do. For instance, lets try extract the metadata of “Humanitarian
Situation Monitoring Round 1, 2022” survey collected from Afghanistan in
2022 and published by UNHCR with unique catalog number ‘1000’.

``` r
metadata(catalog = 1000, org = "unhcr")
# Error in value[[3L]](cond) : 
#  Catalog number 1000 doesn't exist within unhcr organization or no metadata is provided. Check if the data is from external organization using: https://microdata.unhcr.org/index.php/catalog/1000/get-microdata
> 
```

As you can see it couldn’t extract. If you read the returned error
carefully, it suggests possible solutions. In this case, if you we go
and visit the link we see that the data is actually from external
repository. ![The website](man/figures/README-get-data.png)

Lets extract the metadata of “COVID-19 National Panel Phone Survey 2020,
Wave 1” survey collected from Djibouti in 2020 and published by UNHCR
with unique catalog number ‘397’. It returns five key information about
each data files such as description and number of variables. The third
column, which is File name, is very important for next step.

``` r
md <- metadata(catalog = 397, org = "unhcr")
kableExtra::kable(md)
```

| Data file                     | Description                                                                                                                                                                                                                             | File name | Cases | Variables |
|:------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------|------:|----------:|
| ecv_breadwinners_wave1.dta    | This file contains COVID-19 National Panel Phone Survey 2020 (Wave 1) data on the breadwinners of the household.                                                                                                                        | F1        |  1372 |         5 |
| ecv_household_wave1.dta       | This file contains COVID-19 National Panel Phone Survey 2020 (Wave 1) data on: - Knowledge and Behavior Regarding COVID-19 - Employment - Household’s Income - Access to Basic Goods - Access to Healthcare and Education - Safety Nets | F2        |  1486 |       136 |
| ecv_householdroster_wave1.dta | This is the COVID-19 National Panel Phone Survey 2020 (Wave 1) household roster file.                                                                                                                                                   | F3        |  9808 |         6 |
| ecv_respondents_wave1.dta     | This file contains COVID-19 National Panel Phone Survey 2020 (Wave 1) data on the respondents.                                                                                                                                          | F4        |  1486 |         5 |

## Dictionary

The function `dictionary()` helps to extract provided variables along
with their descriptions using catalog and file name. The filename
argument accepts both “File name” value or “‘File name’?file_name=‘Data
file’”. If you are working with many data files, I recommend using the
structure that includes ‘Data file’ since it helps you later identify
them while importing.

``` r
dct <- dictionary(catalog = 397, filename = "F1", 
                  org = "unhcr", namecol = FALSE)
# we can also use 
# dictionary(catalog = 397, org = "unhcr",
#            filename = "F1?file_name=ecv_breadwinners_wave1.dta", 
#            namecol = FALSE)

# gt::gt(dct)
kableExtra::kable(dct)
```

| var       | desc                                                         |
|:----------|:-------------------------------------------------------------|
| hid_2     | Identifiant du ménage                                        |
| pid       | Numero de ligne de l’individu                                |
| s02q4     | Quel est le sexe du principal soutien economique du menage ? |
| s02q5_rec | Age                                                          |
| s02q6_rec | Lien de parenté avec le chef de ménage                       |

# Creating Workbook

For excel table manipulations, this package depends on `openxlsx`
package. So, I recommend to use that package to organize workbook
instead of this function if you are familiar with its the usage.

``` r
wb <- new_workbook()    # Run this code only once
```

# Dictionary to Workbook

Multiple dictionary files can be written to the same workbook but
different sheets as follows. Give descriptive sheet names and don’t set
`namecol` argument to `FALSE`. See documentation of the function.

``` r
dictionary(catalog = 397, filename = "F1", 
                  org = "unhcr") |> 
        to_workbook(wb, "breadwinners")
dictionary(catalog = 397, filename = "F1", 
                  org = "unhcr") |> 
        to_workbook(wb, "employment")
```

Then, save your workbook to local machine.

``` r
openxlsx::saveWorkbook(wb, "My workbook.xlsx")
```

# Importing Data

Before importing the data, you have to open your excel and set the names
of variable of interest under the name column. This function only
selects variables with the name provided under this column and sets
attributes including new name and descriptions.

``` r
my_data <- import_csv(data = "ecv_breadwinners_wave1.dta", 
                      excel = "My workbook.xlsx", 
                      sheet = "breadwinners")
```
