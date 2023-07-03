*** Settings ***
Library  SeleniumLibrary
Library  Collections
Library  RPA.Tables
Suite Teardown  Close All Browsers

*** Variables ***
${URL}  https://www.brou.com.uy/
${TABLE_XPATH}  //*[@id="p_p_id_cotizacion_WAR_broutmfportlet_INSTANCE_df0HsIO8xsuv_"]/div/div/table
${CSV_FILE}  output.csv

*** Keywords ***
Open Brou Website
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
        ${currency}=  Get Text  ${TABLE_XPATH}/tbody/tr[${index + 1}]/td[1]/div/p
        ${buy_value}=  Get Text  ${TABLE_XPATH}/tbody/tr[${index + 1}]/td[2]/div/p
        ${sell_value}=  Get Text  ${TABLE_XPATH}/tbody/tr[${index + 1}]/td[4]/div/p
        Set To Dictionary  ${row_data}  Currency  ${currency}
        Set To Dictionary  ${row_data}  Buy Value  ${buy_value}
        Set To Dictionary  ${row_data}  Sell Value  ${sell_value}
        Append To List  ${all_row_data}  ${row_data}
    END
    [Return]  ${all_row_data}

Write To CSV
    [Arguments]  ${data}
    ${table}=  Create Table  ${data}
    Write Table To CSV  ${table}  ${CSV_FILE}

*** Tasks ***
Get Brou Data
    Open Brou Website
    Log Table HTML
    ${data}=  Get Table Data
    Write To CSV  ${data}
