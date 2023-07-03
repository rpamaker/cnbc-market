*** Settings ***
Library  SeleniumLibrary
Library  RPA.Tables

*** Variables ***
${URL}  https://www.brou.com.uy/
${TABLE_XPATH}  //*[@id="p_p_id_cotizacion_WAR_broutmfportlet_INSTANCE_df0HsIO8xsuv_"]/div/div/table

*** Keywords ***
Open Browser To Page
    Open Browser  ${URL}  Chrome
    Wait Until Page Contains Element  ${TABLE_XPATH}

Capture And Log Table Data
    @{rows}=  Get WebElements  ${TABLE_XPATH}/tbody/tr
    @{data}=  Create List
    FOR  ${row}  IN  @{rows}
        ${currency}=  Get Text  ${row}/td[1]/div/p
        ${buy_rate}=  Get Text  ${row}/td[2]/div/p
        ${sell_rate}=  Get Text  ${row}/td[4]/div/p
        &{row_data}=  Create Dictionary  Currency=${currency}  Buy_Rate=${buy_rate}  Sell_Rate=${sell_rate}
        Append To List  ${data}  ${row_data}
    END
    FOR  ${row_data}  IN  @{data}
        Log  ${row_data}
    END
    ${table}=  Create Table  ${data}
    Write Table To Csv  ${table}  cotizaciones.csv

*** Test Cases ***
Capture And Log Table Data
    Open Browser To Page
    Capture And Log Table Data
