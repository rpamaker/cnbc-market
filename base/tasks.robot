*** Settings ***
Library  SeleniumLibrary
Library  Collections

*** Keywords ***
Open Browser And Log Table
    Open Browser    https://www.brou.com.uy/    chrome
    Wait Until Page Contains Element    xpath=//*[@id="p_p_id_cotizacion_WAR_broutmfportlet_INSTANCE_df0HsIO8xsuv_"]/div/div/table    timeout=30
    @{rows}=    Get WebElements    xpath=//*[@id="p_p_id_cotizacion_WAR_broutmfportlet_INSTANCE_df0HsIO8xsuv_"]/div/div/table/tbody/tr
    FOR    ${row}    IN    @{rows}
        ${row_html}=    Get Element Attribute    ${row}    outerHTML
        Log    ${row_html}
    END

*** Test Cases ***
Test
    Open Browser And Log Table