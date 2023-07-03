*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
Open Browser And Log Table
    Open Browser    https://www.brou.com.uy/    chrome
    Wait Until Page Contains Element    xpath=//*[@id="p_p_id_cotizacion_WAR_broutmfportlet_INSTANCE_df0HsIO8xsuv_"]/div/div/table    timeout=30
    ${table_html}=    Get Element Attribute    xpath=//*[@id="p_p_id_cotizacion_WAR_broutmfportlet_INSTANCE_df0HsIO8xsuv_"]/div/div/table    outerHTML
    Log    ${table_html}

*** Test Cases ***
Test
    Open Browser And Log Table