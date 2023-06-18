*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://www.brou.com.uy/
${XPATH}  //*[@id="p_p_id_cotizacion_WAR_broutmfportlet_INSTANCE_df0HsIO8xsuv_"]/div/div/table/tbody/tr[1]/td[4]/div/p

*** Test Cases ***
Open Website and Log Value
    Open Browser  ${URL}  Chrome
    Wait Until Element Is Visible  ${XPATH}  30
    ${value}=  Get Text  ${XPATH}
    Log  ${value}
    Close Browser