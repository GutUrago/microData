
<!-- README.md is generated from README.Rmd. Please edit that file -->

# microData

<!-- badges: start -->
<!-- badges: end -->

The goal of microData is to assist the process of obtaining complex
metadata of datasets provided by different organizations. At the moment,
it supports four organizations, namely, Worldbank, FAO, UNHCR and IHSN.
It can extract the names of available dataasets along with their
descriptions and dimensions. Moreover, it has an ability to assist
obtaining the names of variables along with their labels. It enables you
to select only variables that you want and rename them while assigning
variable descriptions as their label attributes. For this process to
happen, you must have an excel installed on your local machine.

## Installation

You can install the development version of microData from
[GitHub](https://github.com/GutUrago/microData) with:

``` r
# install.packages("devtools")
devtools::install_github("GutUrago/microData")
```

## Metadata

The function `metadata()` helps to extract provided file descriptions.

``` r
library(microData)
md <- metadata(2939)            # Returns a data table
# gt::gt(md[1:10])
kableExtra::kable(md[1:10])
```

| Data file                               | Description                                                                                                                 |  Cases | Variables |
|:----------------------------------------|:----------------------------------------------------------------------------------------------------------------------------|-------:|----------:|
| HouseholdGeovariables_IHS3_Rerelease_10 | Household geographic location (2010 survey)                                                                                 |   1619 |       115 |
| PlotGeovariables_IHS3_Rerelease_10      | Plot geographic location (2010 survey)                                                                                      |   2392 |        61 |
| hh_mod_a_filt_10                        | Data collected through 2010 Household Questionnaire, Module A: Household Identification (household level data)              |   1619 |        59 |
| hh_mod_b_10                             | Data collected through 2010 Household Questionnaire, Module B: Household Roster (individual level data)                     |   7682 |        42 |
| hh_mod_c_10                             | Data collected through 2010 Household Questionnaire, Module C: Education (individual level data)                            |   7682 |        45 |
| hh_mod_d_10                             | Data collected through 2010 Household Questionnaire, Module D: Health (individual level data)                               |   7682 |        71 |
| hh_mod_e_10                             | Data collected through 2010 Household Questionnaire, Module E: Time Use and Labour - individual level data                  |   7682 |        85 |
| hh_mod_f_10                             | Data collected through 2010 Household Questionnaire, Module F: Housing - household level data                               |   1619 |        70 |
| hh_mod_g1_10                            | Data collected through 2010 Household Questionnaire, Module G: Food Consumption Over Past One Week - consumption item level | 200756 |        21 |
| hh_mod_g2_10                            | Data collected through 2010 Household Questionnaire, Module G: Food Consumption Over Past One Week - food group (aggregate) |  16190 |         8 |

## Dictionary

The function `dictionary()` helps to extract provided variables along
with their descriptions.

``` r
dct <- dictionary(2939, "F17", namecol = FALSE)            # Returns a data table
# gt::gt(dct)
kableExtra::kable(dct)
```

| var     | desc                                                                          |
|:--------|:------------------------------------------------------------------------------|
| HHID    | Assigned Unique Serial Number for IHS3 Baseline Household                     |
| case_id | IHS3 Baseline case_id as in IHS3 Public Data                                  |
| qx_type | Sample Group (Panel A, Panel B)                                               |
| visit   | Panel Visit                                                                   |
| ea_id   | Unique EA Identifier                                                          |
| hh_l01  | Does your household own a \[ITEM\]                                            |
| hh_l02  | Durable Good Code                                                             |
| hh_l03  | How many \[ITEM\]s do you own?                                                |
| hh_l04  | What is the age of this \[ITEM\]                                              |
| hh_l05  | If you wanted to sell one of this \[ITEM\] today, how much would you receive? |
| hh_l06  | Did you purchase any \[ITEM\] in the last 12 months?                          |
| hh_l07  | How much in total did you pay for \[ITEM\] in the last 12 months?             |

# Creating Workbook

For excel table manipulations, this package depends on `openxlsx`
package. So, I recommend to use it to organize workbook instead of this
function if you are familiar with the usage of that package.

``` r
wb <- new_workbook()    # Run this code only once
```

# Dictionary to Workbook

Multiple dictionary files can be written to the same workbook but
different sheets as follows.

``` r
dictionary(2939, "F17") |> to_workbook(wb, "Goods")
dictionary(2939, "F18") |> to_workbook(wb, "Machines")
```

Then save the workbook to local machine.

``` r
openxlsx::saveWorkbook(wb, "My workbook.xlsx")
```

# Importing Data

Before importing the data, you have to open your excel and set the names
of variable of interest under the name column. This function only
selects variables with the name provided under this colummn and sets
attributes including new name and descriptions.

``` r
my_data <- import_csv(data, 
                      excel = "My workbook.xlsx", 
                      sheet = "Goods")
```
