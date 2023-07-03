*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://finance.yahoo.com/
${TABLE_XPATH}  //*[@id="data-util-col"]/section[3]/table
${CSV_FILE}  output.csv

*** Keywords ***
Open Browser To Page
    Open Browser  ${URL}  browser=firefox
    Maximize Browser Window
    Wait Until Page Contains Element  ${TABLE_XPATH}

Get Table Data
    @{table_rows}  Get WebElements  ${TABLE_XPATH}/tbody/tr
    FOR  ${row}  IN  @{table_rows}
        ${row_html}  Get Element Attribute  ${row}  outerHTML
        Log  ${row_html}
        @{cells}  Get WebElements  ${row}/td
        ${symbol}  Get Text  @{cells}[0]
        ${last_price}  Get Text  @{cells}[1]
        ${change}  Get Text  @{cells}[2]
        ${percent_change}  Get Text  @{cells}[3]
        @{data}=  Create List  ${symbol}  ${last_price}  ${change}  ${percent_change}
        Append To Csv File  ${CSV_FILE}  @{data}
    END

*** Test Cases ***
Get Yahoo Finance Data
    Open Browser To Page
    Get Table Data