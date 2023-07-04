*** Settings ***
Library  SeleniumLibrary
Suite Teardown  Close All Browsers

*** Variables ***
${URL}  https://www.brou.com.uy/
${TABLE_XPATH}  //*[@id="p_p_id_cotizacion_WAR_broutmfportlet_INSTANCE_df0HsIO8xsuv_"]/div/div/table/tbody

*** Tasks ***
Open Website and Log Exchange Rates
    Open Browser  ${URL}  browser=chrome
    Wait Until Page Contains Element  ${TABLE_XPATH}  timeout=30
    ${table_data}=  Get Text  ${TABLE_XPATH}
    Log  ${table_data}