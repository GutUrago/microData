
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

Note: I used customized gt table theme that I created in [this
blog](https://guturago.github.io/blog/gt-table-theme/).

``` r
library(microData)

collections(org = "wb") |> 
  head() |> 
  my_gt_theme()
```

<div id="jkwanvisai" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#jkwanvisai table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#jkwanvisai thead, #jkwanvisai tbody, #jkwanvisai tfoot, #jkwanvisai tr, #jkwanvisai td, #jkwanvisai th {
  border-style: none;
}
&#10;#jkwanvisai p {
  margin: 0;
  padding: 0;
}
&#10;#jkwanvisai .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: 100%;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#jkwanvisai .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#jkwanvisai .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#jkwanvisai .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#jkwanvisai .gt_heading {
  background-color: #FFFFFF;
  text-align: left;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#jkwanvisai .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#jkwanvisai .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#jkwanvisai .gt_col_heading {
  color: #FFFFFF;
  background-color: #4682B4;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#jkwanvisai .gt_column_spanner_outer {
  color: #FFFFFF;
  background-color: #4682B4;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#jkwanvisai .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#jkwanvisai .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#jkwanvisai .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#jkwanvisai .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#jkwanvisai .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#jkwanvisai .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#jkwanvisai .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#jkwanvisai .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#jkwanvisai .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#jkwanvisai .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#jkwanvisai .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#jkwanvisai .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#jkwanvisai .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#jkwanvisai .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#jkwanvisai .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#jkwanvisai .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#jkwanvisai .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#jkwanvisai .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#jkwanvisai .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#jkwanvisai .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#jkwanvisai .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#jkwanvisai .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#jkwanvisai .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#jkwanvisai .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#jkwanvisai .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#jkwanvisai .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#jkwanvisai .gt_left {
  text-align: left;
}
&#10;#jkwanvisai .gt_center {
  text-align: center;
}
&#10;#jkwanvisai .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#jkwanvisai .gt_font_normal {
  font-weight: normal;
}
&#10;#jkwanvisai .gt_font_bold {
  font-weight: bold;
}
&#10;#jkwanvisai .gt_font_italic {
  font-style: italic;
}
&#10;#jkwanvisai .gt_super {
  font-size: 65%;
}
&#10;#jkwanvisai .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#jkwanvisai .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#jkwanvisai .gt_indent_1 {
  text-indent: 5px;
}
&#10;#jkwanvisai .gt_indent_2 {
  text-indent: 10px;
}
&#10;#jkwanvisai .gt_indent_3 {
  text-indent: 15px;
}
&#10;#jkwanvisai .gt_indent_4 {
  text-indent: 20px;
}
&#10;#jkwanvisai .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="id">id</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="repo_id">repo_id</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="title">title</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="id" class="gt_row gt_right" style="background-color: #E5E5E5;">26</td>
<td headers="repo_id" class="gt_row gt_left" style="background-color: #E5E5E5;">afrobarometer</td>
<td headers="title" class="gt_row gt_left" style="background-color: #E5E5E5;">Afrobarometer</td></tr>
    <tr><td headers="id" class="gt_row gt_right">2</td>
<td headers="repo_id" class="gt_row gt_left">datafirst</td>
<td headers="title" class="gt_row gt_left">DataFirst , University of Cape Town, South Africa</td></tr>
    <tr><td headers="id" class="gt_row gt_right" style="background-color: #E5E5E5;">22</td>
<td headers="repo_id" class="gt_row gt_left" style="background-color: #E5E5E5;">dime</td>
<td headers="title" class="gt_row gt_left" style="background-color: #E5E5E5;">Development Impact Evaluation (DIME)</td></tr>
    <tr><td headers="id" class="gt_row gt_right">1</td>
<td headers="repo_id" class="gt_row gt_left">microdata_rg</td>
<td headers="title" class="gt_row gt_left">Development Research Microdata</td></tr>
    <tr><td headers="id" class="gt_row gt_right" style="background-color: #E5E5E5;">4</td>
<td headers="repo_id" class="gt_row gt_left" style="background-color: #E5E5E5;">enterprise_surveys</td>
<td headers="title" class="gt_row gt_left" style="background-color: #E5E5E5;">Enterprise Surveys</td></tr>
    <tr><td headers="id" class="gt_row gt_right">30</td>
<td headers="repo_id" class="gt_row gt_left">fao</td>
<td headers="title" class="gt_row gt_left">FAO - Food and Agriculture Microdata Catalog</td></tr>
  </tbody>
  &#10;  
</table>
</div>

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
  results = 10)
```

There is also handy function to check latest publications of these
datasets.

``` r
latest_entries(org = "wb", limit = 15)
```

You can use `data_files` to see the data files included in the study.
Let’s see one of the popular survey on the WB. We can also use id number
of the study, which is 3110 instead of the name (See next code chunk).

``` r
data_files(id = "TZA_1991_KHDS_v01_M", org = "wb") |> 
  head() |>
  my_gt_theme()
```

<div id="noayhroewz" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#noayhroewz table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#noayhroewz thead, #noayhroewz tbody, #noayhroewz tfoot, #noayhroewz tr, #noayhroewz td, #noayhroewz th {
  border-style: none;
}
&#10;#noayhroewz p {
  margin: 0;
  padding: 0;
}
&#10;#noayhroewz .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: 100%;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#noayhroewz .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#noayhroewz .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#noayhroewz .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#noayhroewz .gt_heading {
  background-color: #FFFFFF;
  text-align: left;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#noayhroewz .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#noayhroewz .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#noayhroewz .gt_col_heading {
  color: #FFFFFF;
  background-color: #4682B4;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#noayhroewz .gt_column_spanner_outer {
  color: #FFFFFF;
  background-color: #4682B4;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#noayhroewz .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#noayhroewz .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#noayhroewz .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#noayhroewz .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#noayhroewz .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#noayhroewz .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#noayhroewz .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#noayhroewz .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#noayhroewz .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#noayhroewz .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#noayhroewz .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#noayhroewz .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#noayhroewz .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#noayhroewz .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#noayhroewz .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#noayhroewz .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#noayhroewz .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#noayhroewz .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#noayhroewz .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#noayhroewz .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#noayhroewz .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#noayhroewz .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#noayhroewz .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#noayhroewz .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#noayhroewz .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#noayhroewz .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#noayhroewz .gt_left {
  text-align: left;
}
&#10;#noayhroewz .gt_center {
  text-align: center;
}
&#10;#noayhroewz .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#noayhroewz .gt_font_normal {
  font-weight: normal;
}
&#10;#noayhroewz .gt_font_bold {
  font-weight: bold;
}
&#10;#noayhroewz .gt_font_italic {
  font-style: italic;
}
&#10;#noayhroewz .gt_super {
  font-size: 65%;
}
&#10;#noayhroewz .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#noayhroewz .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#noayhroewz .gt_indent_1 {
  text-indent: 5px;
}
&#10;#noayhroewz .gt_indent_2 {
  text-indent: 10px;
}
&#10;#noayhroewz .gt_indent_3 {
  text-indent: 15px;
}
&#10;#noayhroewz .gt_indent_4 {
  text-indent: 20px;
}
&#10;#noayhroewz .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="id">id</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="sid">sid</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="file_id">file_id</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="file_name">file_name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="description">description</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="case_count">case_count</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="var_count">var_count</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="id" class="gt_row gt_center" style="background-color: #E5E5E5;">81328</td>
<td headers="sid" class="gt_row gt_center" style="background-color: #E5E5E5;">359</td>
<td headers="file_id" class="gt_row gt_center" style="background-color: #E5E5E5;">F1</td>
<td headers="file_name" class="gt_row gt_center" style="background-color: #E5E5E5;">Wave1_HH_S_____HH</td>
<td headers="description" class="gt_row gt_center" style="background-color: #E5E5E5;">Miscellaneous</td>
<td headers="case_count" class="gt_row gt_center" style="background-color: #E5E5E5;">981</td>
<td headers="var_count" class="gt_row gt_center" style="background-color: #E5E5E5;">163</td></tr>
    <tr><td headers="id" class="gt_row gt_center">81329</td>
<td headers="sid" class="gt_row gt_center">359</td>
<td headers="file_id" class="gt_row gt_center">F2</td>
<td headers="file_name" class="gt_row gt_center">Wave1_HH_S00B_OTH</td>
<td headers="description" class="gt_row gt_center">Section
verification</td>
<td headers="case_count" class="gt_row gt_center">18258</td>
<td headers="var_count" class="gt_row gt_center">16</td></tr>
    <tr><td headers="id" class="gt_row gt_center" style="background-color: #E5E5E5;">81330</td>
<td headers="sid" class="gt_row gt_center" style="background-color: #E5E5E5;">359</td>
<td headers="file_id" class="gt_row gt_center" style="background-color: #E5E5E5;">F3</td>
<td headers="file_name" class="gt_row gt_center" style="background-color: #E5E5E5;">Wave1_HH_S1___IND</td>
<td headers="description" class="gt_row gt_center" style="background-color: #E5E5E5;">Household Roster</td>
<td headers="case_count" class="gt_row gt_center" style="background-color: #E5E5E5;">5373</td>
<td headers="var_count" class="gt_row gt_center" style="background-color: #E5E5E5;">25</td></tr>
    <tr><td headers="id" class="gt_row gt_center">81331</td>
<td headers="sid" class="gt_row gt_center">359</td>
<td headers="file_id" class="gt_row gt_center">F4</td>
<td headers="file_name" class="gt_row gt_center">Wave1_HH_S2___KID</td>
<td headers="description" class="gt_row gt_center">Children Residing Elsewhere</td>
<td headers="case_count" class="gt_row gt_center">3394</td>
<td headers="var_count" class="gt_row gt_center">28</td></tr>
    <tr><td headers="id" class="gt_row gt_center" style="background-color: #E5E5E5;">81332</td>
<td headers="sid" class="gt_row gt_center" style="background-color: #E5E5E5;">359</td>
<td headers="file_id" class="gt_row gt_center" style="background-color: #E5E5E5;">F5</td>
<td headers="file_name" class="gt_row gt_center" style="background-color: #E5E5E5;">Wave1_HH_S3___IND</td>
<td headers="description" class="gt_row gt_center" style="background-color: #E5E5E5;">Parents</td>
<td headers="case_count" class="gt_row gt_center" style="background-color: #E5E5E5;">5298</td>
<td headers="var_count" class="gt_row gt_center" style="background-color: #E5E5E5;">27</td></tr>
    <tr><td headers="id" class="gt_row gt_center">81333</td>
<td headers="sid" class="gt_row gt_center">359</td>
<td headers="file_id" class="gt_row gt_center">F6</td>
<td headers="file_name" class="gt_row gt_center">Wave1_HH_S4___BUS</td>
<td headers="description" class="gt_row gt_center">Overview of Household Businesses</td>
<td headers="case_count" class="gt_row gt_center">334</td>
<td headers="var_count" class="gt_row gt_center">7</td></tr>
  </tbody>
  &#10;  
</table>
</div>

How about variables included in the data file? Of course you can check
them as well.

``` r
variables(id = 359, file_id = "F3") |> 
  head() |> 
  my_gt_theme()
```

<div id="rxazendfhl" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#rxazendfhl table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#rxazendfhl thead, #rxazendfhl tbody, #rxazendfhl tfoot, #rxazendfhl tr, #rxazendfhl td, #rxazendfhl th {
  border-style: none;
}
&#10;#rxazendfhl p {
  margin: 0;
  padding: 0;
}
&#10;#rxazendfhl .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: 100%;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#rxazendfhl .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#rxazendfhl .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#rxazendfhl .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#rxazendfhl .gt_heading {
  background-color: #FFFFFF;
  text-align: left;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#rxazendfhl .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#rxazendfhl .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#rxazendfhl .gt_col_heading {
  color: #FFFFFF;
  background-color: #4682B4;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#rxazendfhl .gt_column_spanner_outer {
  color: #FFFFFF;
  background-color: #4682B4;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#rxazendfhl .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#rxazendfhl .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#rxazendfhl .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#rxazendfhl .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#rxazendfhl .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#rxazendfhl .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#rxazendfhl .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#rxazendfhl .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#rxazendfhl .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#rxazendfhl .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#rxazendfhl .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#rxazendfhl .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#rxazendfhl .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#rxazendfhl .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#rxazendfhl .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#rxazendfhl .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#rxazendfhl .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#rxazendfhl .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#rxazendfhl .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#rxazendfhl .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#rxazendfhl .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#rxazendfhl .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#rxazendfhl .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#rxazendfhl .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#rxazendfhl .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#rxazendfhl .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#rxazendfhl .gt_left {
  text-align: left;
}
&#10;#rxazendfhl .gt_center {
  text-align: center;
}
&#10;#rxazendfhl .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#rxazendfhl .gt_font_normal {
  font-weight: normal;
}
&#10;#rxazendfhl .gt_font_bold {
  font-weight: bold;
}
&#10;#rxazendfhl .gt_font_italic {
  font-style: italic;
}
&#10;#rxazendfhl .gt_super {
  font-size: 65%;
}
&#10;#rxazendfhl .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#rxazendfhl .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#rxazendfhl .gt_indent_1 {
  text-indent: 5px;
}
&#10;#rxazendfhl .gt_indent_2 {
  text-indent: 10px;
}
&#10;#rxazendfhl .gt_indent_3 {
  text-indent: 15px;
}
&#10;#rxazendfhl .gt_indent_4 {
  text-indent: 20px;
}
&#10;#rxazendfhl .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="uid">uid</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="sid">sid</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="fid">fid</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="vid">vid</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="name">name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="labl">labl</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="uid" class="gt_row gt_right" style="background-color: #E5E5E5;">265957</td>
<td headers="sid" class="gt_row gt_right" style="background-color: #E5E5E5;">359</td>
<td headers="fid" class="gt_row gt_left" style="background-color: #E5E5E5;">F3</td>
<td headers="vid" class="gt_row gt_left" style="background-color: #E5E5E5;">V180</td>
<td headers="name" class="gt_row gt_left" style="background-color: #E5E5E5;">cluster</td>
<td headers="labl" class="gt_row gt_left" style="background-color: #E5E5E5;">Cluster</td></tr>
    <tr><td headers="uid" class="gt_row gt_right">265958</td>
<td headers="sid" class="gt_row gt_right">359</td>
<td headers="fid" class="gt_row gt_left">F3</td>
<td headers="vid" class="gt_row gt_left">V181</td>
<td headers="name" class="gt_row gt_left">hh</td>
<td headers="labl" class="gt_row gt_left">Household Number</td></tr>
    <tr><td headers="uid" class="gt_row gt_right" style="background-color: #E5E5E5;">265959</td>
<td headers="sid" class="gt_row gt_right" style="background-color: #E5E5E5;">359</td>
<td headers="fid" class="gt_row gt_left" style="background-color: #E5E5E5;">F3</td>
<td headers="vid" class="gt_row gt_left" style="background-color: #E5E5E5;">V182</td>
<td headers="name" class="gt_row gt_left" style="background-color: #E5E5E5;">id</td>
<td headers="labl" class="gt_row gt_left" style="background-color: #E5E5E5;">Individual ID Code in HH</td></tr>
    <tr><td headers="uid" class="gt_row gt_right">265960</td>
<td headers="sid" class="gt_row gt_right">359</td>
<td headers="fid" class="gt_row gt_left">F3</td>
<td headers="vid" class="gt_row gt_left">V183</td>
<td headers="name" class="gt_row gt_left">wave</td>
<td headers="labl" class="gt_row gt_left">Wave</td></tr>
    <tr><td headers="uid" class="gt_row gt_right" style="background-color: #E5E5E5;">265961</td>
<td headers="sid" class="gt_row gt_right" style="background-color: #E5E5E5;">359</td>
<td headers="fid" class="gt_row gt_left" style="background-color: #E5E5E5;">F3</td>
<td headers="vid" class="gt_row gt_left" style="background-color: #E5E5E5;">V184</td>
<td headers="name" class="gt_row gt_left" style="background-color: #E5E5E5;">passage</td>
<td headers="labl" class="gt_row gt_left" style="background-color: #E5E5E5;">Passage</td></tr>
    <tr><td headers="uid" class="gt_row gt_right">265962</td>
<td headers="sid" class="gt_row gt_right">359</td>
<td headers="fid" class="gt_row gt_left">F3</td>
<td headers="vid" class="gt_row gt_left">V185</td>
<td headers="name" class="gt_row gt_left">sex</td>
<td headers="labl" class="gt_row gt_left">S1Q2: Sex</td></tr>
  </tbody>
  &#10;  
</table>
</div>

## Setting Attributes

Variables in microdata are often named something that has nothing to do
with the variable except question order like this.

<div id="vweblhabor" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#vweblhabor table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#vweblhabor thead, #vweblhabor tbody, #vweblhabor tfoot, #vweblhabor tr, #vweblhabor td, #vweblhabor th {
  border-style: none;
}
&#10;#vweblhabor p {
  margin: 0;
  padding: 0;
}
&#10;#vweblhabor .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: 100%;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#vweblhabor .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#vweblhabor .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#vweblhabor .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#vweblhabor .gt_heading {
  background-color: #FFFFFF;
  text-align: left;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#vweblhabor .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#vweblhabor .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#vweblhabor .gt_col_heading {
  color: #FFFFFF;
  background-color: #4682B4;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#vweblhabor .gt_column_spanner_outer {
  color: #FFFFFF;
  background-color: #4682B4;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#vweblhabor .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#vweblhabor .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#vweblhabor .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#vweblhabor .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#vweblhabor .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#vweblhabor .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#vweblhabor .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#vweblhabor .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#vweblhabor .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#vweblhabor .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#vweblhabor .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#vweblhabor .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#vweblhabor .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#vweblhabor .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#vweblhabor .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#vweblhabor .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#vweblhabor .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#vweblhabor .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#vweblhabor .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#vweblhabor .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#vweblhabor .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#vweblhabor .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#vweblhabor .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#vweblhabor .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#vweblhabor .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#vweblhabor .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#vweblhabor .gt_left {
  text-align: left;
}
&#10;#vweblhabor .gt_center {
  text-align: center;
}
&#10;#vweblhabor .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#vweblhabor .gt_font_normal {
  font-weight: normal;
}
&#10;#vweblhabor .gt_font_bold {
  font-weight: bold;
}
&#10;#vweblhabor .gt_font_italic {
  font-style: italic;
}
&#10;#vweblhabor .gt_super {
  font-size: 65%;
}
&#10;#vweblhabor .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#vweblhabor .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#vweblhabor .gt_indent_1 {
  text-indent: 5px;
}
&#10;#vweblhabor .gt_indent_2 {
  text-indent: 10px;
}
&#10;#vweblhabor .gt_indent_3 {
  text-indent: 15px;
}
&#10;#vweblhabor .gt_indent_4 {
  text-indent: 20px;
}
&#10;#vweblhabor .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="id">id</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="v1">v1</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="v2">v2</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="v3">v3</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="v4">v4</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="id" class="gt_row gt_right" style="background-color: #E5E5E5;">1</td>
<td headers="v1" class="gt_row gt_right" style="background-color: #E5E5E5;">44</td>
<td headers="v2" class="gt_row gt_center" style="background-color: #E5E5E5;">male</td>
<td headers="v3" class="gt_row gt_center" style="background-color: #E5E5E5;">master</td>
<td headers="v4" class="gt_row gt_right" style="background-color: #E5E5E5;">6395.007</td></tr>
    <tr><td headers="id" class="gt_row gt_right">2</td>
<td headers="v1" class="gt_row gt_right">48</td>
<td headers="v2" class="gt_row gt_center">female</td>
<td headers="v3" class="gt_row gt_center">phd</td>
<td headers="v4" class="gt_row gt_right">7402.144</td></tr>
    <tr><td headers="id" class="gt_row gt_right" style="background-color: #E5E5E5;">3</td>
<td headers="v1" class="gt_row gt_right" style="background-color: #E5E5E5;">43</td>
<td headers="v2" class="gt_row gt_center" style="background-color: #E5E5E5;">female</td>
<td headers="v3" class="gt_row gt_center" style="background-color: #E5E5E5;">master</td>
<td headers="v4" class="gt_row gt_right" style="background-color: #E5E5E5;">5496.753</td></tr>
    <tr><td headers="id" class="gt_row gt_right">4</td>
<td headers="v1" class="gt_row gt_right">32</td>
<td headers="v2" class="gt_row gt_center">female</td>
<td headers="v3" class="gt_row gt_center">phd</td>
<td headers="v4" class="gt_row gt_right">4200.946</td></tr>
    <tr><td headers="id" class="gt_row gt_right" style="background-color: #E5E5E5;">5</td>
<td headers="v1" class="gt_row gt_right" style="background-color: #E5E5E5;">39</td>
<td headers="v2" class="gt_row gt_center" style="background-color: #E5E5E5;">male</td>
<td headers="v3" class="gt_row gt_center" style="background-color: #E5E5E5;">master</td>
<td headers="v4" class="gt_row gt_right" style="background-color: #E5E5E5;">5391.046</td></tr>
    <tr><td headers="id" class="gt_row gt_right">6</td>
<td headers="v1" class="gt_row gt_right">47</td>
<td headers="v2" class="gt_row gt_center">female</td>
<td headers="v3" class="gt_row gt_center">phd</td>
<td headers="v4" class="gt_row gt_right">7186.892</td></tr>
  </tbody>
  &#10;  
</table>
</div>

Then you can prepare another data that contains metadata like this. It
will be explained in detail in vignettes later.

<div id="scwfghycmj" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#scwfghycmj table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#scwfghycmj thead, #scwfghycmj tbody, #scwfghycmj tfoot, #scwfghycmj tr, #scwfghycmj td, #scwfghycmj th {
  border-style: none;
}
&#10;#scwfghycmj p {
  margin: 0;
  padding: 0;
}
&#10;#scwfghycmj .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: 100%;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#scwfghycmj .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#scwfghycmj .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#scwfghycmj .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#scwfghycmj .gt_heading {
  background-color: #FFFFFF;
  text-align: left;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#scwfghycmj .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#scwfghycmj .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#scwfghycmj .gt_col_heading {
  color: #FFFFFF;
  background-color: #4682B4;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#scwfghycmj .gt_column_spanner_outer {
  color: #FFFFFF;
  background-color: #4682B4;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#scwfghycmj .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#scwfghycmj .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#scwfghycmj .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#scwfghycmj .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#scwfghycmj .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#scwfghycmj .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#scwfghycmj .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#scwfghycmj .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#scwfghycmj .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#scwfghycmj .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#scwfghycmj .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#scwfghycmj .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#scwfghycmj .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#scwfghycmj .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#scwfghycmj .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#scwfghycmj .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#scwfghycmj .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#scwfghycmj .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#scwfghycmj .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#scwfghycmj .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#scwfghycmj .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#scwfghycmj .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#scwfghycmj .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#scwfghycmj .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#scwfghycmj .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#scwfghycmj .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#scwfghycmj .gt_left {
  text-align: left;
}
&#10;#scwfghycmj .gt_center {
  text-align: center;
}
&#10;#scwfghycmj .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#scwfghycmj .gt_font_normal {
  font-weight: normal;
}
&#10;#scwfghycmj .gt_font_bold {
  font-weight: bold;
}
&#10;#scwfghycmj .gt_font_italic {
  font-style: italic;
}
&#10;#scwfghycmj .gt_super {
  font-size: 65%;
}
&#10;#scwfghycmj .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#scwfghycmj .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#scwfghycmj .gt_indent_1 {
  text-indent: 5px;
}
&#10;#scwfghycmj .gt_indent_2 {
  text-indent: 10px;
}
&#10;#scwfghycmj .gt_indent_3 {
  text-indent: 15px;
}
&#10;#scwfghycmj .gt_indent_4 {
  text-indent: 20px;
}
&#10;#scwfghycmj .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="var_id">var_id</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="var_name">var_name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="label">label</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="var_id" class="gt_row gt_left" style="background-color: #E5E5E5;">id</td>
<td headers="var_name" class="gt_row gt_left" style="background-color: #E5E5E5;">individual_id</td>
<td headers="label" class="gt_row gt_left" style="background-color: #E5E5E5;">Respondent ID</td></tr>
    <tr><td headers="var_id" class="gt_row gt_left">v1</td>
<td headers="var_name" class="gt_row gt_left">age</td>
<td headers="label" class="gt_row gt_left">Age of respondent</td></tr>
    <tr><td headers="var_id" class="gt_row gt_left" style="background-color: #E5E5E5;">v2</td>
<td headers="var_name" class="gt_row gt_left" style="background-color: #E5E5E5;">sex</td>
<td headers="label" class="gt_row gt_left" style="background-color: #E5E5E5;">Sex of respondent</td></tr>
    <tr><td headers="var_id" class="gt_row gt_left">v3</td>
<td headers="var_name" class="gt_row gt_left">education</td>
<td headers="label" class="gt_row gt_left">Educational level</td></tr>
    <tr><td headers="var_id" class="gt_row gt_left" style="background-color: #E5E5E5;">v4</td>
<td headers="var_name" class="gt_row gt_left" style="background-color: #E5E5E5;">salary</td>
<td headers="label" class="gt_row gt_left" style="background-color: #E5E5E5;">Monthly salay ($)</td></tr>
  </tbody>
  &#10;  
</table>
</div>

You can use `set_attributes` function to rename and set labels to these
variables.

``` r
my_data <- set_attributes(
  mdt, 
  mtdt,
  old_name = var_id,
  new_name = var_name,
  label = label)

head(my_data) |> my_gt_theme()
```

<div id="nfeyvcbrul" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#nfeyvcbrul table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#nfeyvcbrul thead, #nfeyvcbrul tbody, #nfeyvcbrul tfoot, #nfeyvcbrul tr, #nfeyvcbrul td, #nfeyvcbrul th {
  border-style: none;
}
&#10;#nfeyvcbrul p {
  margin: 0;
  padding: 0;
}
&#10;#nfeyvcbrul .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: 100%;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#nfeyvcbrul .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#nfeyvcbrul .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#nfeyvcbrul .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#nfeyvcbrul .gt_heading {
  background-color: #FFFFFF;
  text-align: left;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#nfeyvcbrul .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#nfeyvcbrul .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#nfeyvcbrul .gt_col_heading {
  color: #FFFFFF;
  background-color: #4682B4;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#nfeyvcbrul .gt_column_spanner_outer {
  color: #FFFFFF;
  background-color: #4682B4;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#nfeyvcbrul .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#nfeyvcbrul .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#nfeyvcbrul .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#nfeyvcbrul .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#nfeyvcbrul .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#nfeyvcbrul .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#nfeyvcbrul .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#nfeyvcbrul .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#nfeyvcbrul .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#nfeyvcbrul .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#nfeyvcbrul .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#nfeyvcbrul .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#nfeyvcbrul .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#nfeyvcbrul .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#nfeyvcbrul .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#nfeyvcbrul .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#nfeyvcbrul .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#nfeyvcbrul .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#nfeyvcbrul .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#nfeyvcbrul .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#nfeyvcbrul .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#nfeyvcbrul .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#nfeyvcbrul .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#nfeyvcbrul .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#nfeyvcbrul .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#nfeyvcbrul .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#nfeyvcbrul .gt_left {
  text-align: left;
}
&#10;#nfeyvcbrul .gt_center {
  text-align: center;
}
&#10;#nfeyvcbrul .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#nfeyvcbrul .gt_font_normal {
  font-weight: normal;
}
&#10;#nfeyvcbrul .gt_font_bold {
  font-weight: bold;
}
&#10;#nfeyvcbrul .gt_font_italic {
  font-style: italic;
}
&#10;#nfeyvcbrul .gt_super {
  font-size: 65%;
}
&#10;#nfeyvcbrul .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#nfeyvcbrul .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#nfeyvcbrul .gt_indent_1 {
  text-indent: 5px;
}
&#10;#nfeyvcbrul .gt_indent_2 {
  text-indent: 10px;
}
&#10;#nfeyvcbrul .gt_indent_3 {
  text-indent: 15px;
}
&#10;#nfeyvcbrul .gt_indent_4 {
  text-indent: 20px;
}
&#10;#nfeyvcbrul .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="individual_id">individual_id</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="age">age</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="sex">sex</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="education">education</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col" id="salary">salary</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="individual_id" class="gt_row gt_right" style="background-color: #E5E5E5;">1</td>
<td headers="age" class="gt_row gt_right" style="background-color: #E5E5E5;">44</td>
<td headers="sex" class="gt_row gt_center" style="background-color: #E5E5E5;">male</td>
<td headers="education" class="gt_row gt_center" style="background-color: #E5E5E5;">master</td>
<td headers="salary" class="gt_row gt_right" style="background-color: #E5E5E5;">6395.007</td></tr>
    <tr><td headers="individual_id" class="gt_row gt_right">2</td>
<td headers="age" class="gt_row gt_right">48</td>
<td headers="sex" class="gt_row gt_center">female</td>
<td headers="education" class="gt_row gt_center">phd</td>
<td headers="salary" class="gt_row gt_right">7402.144</td></tr>
    <tr><td headers="individual_id" class="gt_row gt_right" style="background-color: #E5E5E5;">3</td>
<td headers="age" class="gt_row gt_right" style="background-color: #E5E5E5;">43</td>
<td headers="sex" class="gt_row gt_center" style="background-color: #E5E5E5;">female</td>
<td headers="education" class="gt_row gt_center" style="background-color: #E5E5E5;">master</td>
<td headers="salary" class="gt_row gt_right" style="background-color: #E5E5E5;">5496.753</td></tr>
    <tr><td headers="individual_id" class="gt_row gt_right">4</td>
<td headers="age" class="gt_row gt_right">32</td>
<td headers="sex" class="gt_row gt_center">female</td>
<td headers="education" class="gt_row gt_center">phd</td>
<td headers="salary" class="gt_row gt_right">4200.946</td></tr>
    <tr><td headers="individual_id" class="gt_row gt_right" style="background-color: #E5E5E5;">5</td>
<td headers="age" class="gt_row gt_right" style="background-color: #E5E5E5;">39</td>
<td headers="sex" class="gt_row gt_center" style="background-color: #E5E5E5;">male</td>
<td headers="education" class="gt_row gt_center" style="background-color: #E5E5E5;">master</td>
<td headers="salary" class="gt_row gt_right" style="background-color: #E5E5E5;">5391.046</td></tr>
    <tr><td headers="individual_id" class="gt_row gt_right">6</td>
<td headers="age" class="gt_row gt_right">47</td>
<td headers="sex" class="gt_row gt_center">female</td>
<td headers="education" class="gt_row gt_center">phd</td>
<td headers="salary" class="gt_row gt_right">7186.892</td></tr>
  </tbody>
  &#10;  
</table>
</div>

labels are also assigned.

``` r
str(my_data)
#> 'data.frame':    100 obs. of  5 variables:
#>  $ individual_id: int  1 2 3 4 5 6 7 8 9 10 ...
#>   ..- attr(*, "label")= chr "Respondent ID"
#>  $ age          : int  44 48 43 32 39 47 40 34 49 43 ...
#>   ..- attr(*, "label")= chr "Age of respondent"
#>  $ sex          : Factor w/ 2 levels "female","male": 2 1 1 1 2 1 2 2 1 2 ...
#>   ..- attr(*, "label")= chr "Sex of respondent"
#>  $ education    : Factor w/ 3 levels "bachelor","master",..: 2 3 2 3 2 3 1 1 1 1 ...
#>   ..- attr(*, "label")= chr "Educational level"
#>  $ salary       : num  6395 7402 5497 4201 5391 ...
#>   ..- attr(*, "label")= chr "Monthly salay ($)"
```

More coming soon!
