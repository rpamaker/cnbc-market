*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://www.bcu.gub.uy/Estadisticas-e-Indicadores/Paginas/Cotizaciones.aspx
${XPATH1}  //*[@id="recaptcha-anchor"]/div[1]
${XPATH2}  //*[@id="ctl00_ctl63_g_0723770d_f942_45cc_80db_28dc7fa543a2_ctl00_lstCotizaciones"]/tbody/tr[1]/td[4]

*** Tasks ***
Open Website and Log Value
    Open Browser  ${URL}  Chrome
    Wait Until Element Is Visible  ${XPATH1}
    Click Element  ${XPATH1}
    Wait Until Element Is Visible  ${XPATH2}
    ${value}=  Get Text  ${XPATH2}
    Log  ${value}
    Close Browser