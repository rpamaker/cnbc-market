*** Settings ***
Library  SeleniumLibrary
Library  Collections
Library  RPA.Tables
Suite Teardown  Close All Browsers

*** Variables ***
${URL}  https://finance.yahoo.com/
${TABLE_XPATH}  //*[@id="data-util-col"]/section[3]/table
${CSV_FILE}  output.csv

*** Keywords ***
Open Yahoo Finance
    Open Browser  ${URL}  browser=chrome
    Wait Until Page Contains Element  ${TABLE_XPATH}

Log Table HTML
    ${table_html}=  Get Element Attribute  ${TABLE_XPATH}  outerHTML
    Log  ${table_html}

Get Table Data
    @{all_row_data}=  Create List
    ${rows}=  Get WebElements  ${TABLE_XPATH}/tbody/tr
    ${row_count}=  Get Length  ${rows}
    FOR  ${index}  IN RANGE  0  ${row_count}
        ${row_data}=  Create Dictionary
        ${symbol}=  Get Text  ${TABLE_XPATH}/tbody/tr[${index + 1}]/td[1]/a
        ${last_price}=  Get Text  ${TABLE_XPATH}/tbody/tr[${index + 1}]/td[2]
        ${change}=  Get Text  ${TABLE_XPATH}/tbody/tr[${index + 1}]/td[3]
        ${percent_change}=  Get Text  ${TABLE_XPATH}/tbody/tr[${index + 1}]/td[4]
        Set To Dictionary  ${row_data}  Symbol  ${symbol}
        Set To Dictionary  ${row_data}  Last Price  ${last_price}
        Set To Dictionary  ${row_data}  Change  ${change}
        Set To Dictionary  ${row_data}  % Change  ${percent_change}
        Append To List  ${all_row_data}  ${row_data}
    END
    [Return]  ${all_row_data}

Write To CSV
    [Arguments]  ${data}
    ${table}=  Create Table  ${data}
    Write Table To CSV  ${table}  ${CSV_FILE}

*** Tasks ***
Get Yahoo Finance Data
    Open Yahoo Finance
    Log Table HTML
    ${data}=  Get Table Data
    Write To CSV  ${data}
