*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://www.brou.com.uy/
${TABLE_XPATH}  //*[@id="p_p_id_cotizacion_WAR_broutmfportlet_INSTANCE_df0HsIO8xsuv_"]/div/div/table

*** Keywords ***
Open Browser To Page
    Open Browser  ${URL}  Chrome
    Wait Until Page Contains Element  ${TABLE_XPATH}

Capture Table HTML
    ${table_html}=  Get Element Attribute  ${TABLE_XPATH}  outerHTML
    [Return]  ${table_html}

*** Test Cases ***
Capture Table
    Open Browser To Page
    ${table_html}=  Capture Table HTML
    Log  ${table_html}
