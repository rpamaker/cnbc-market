*** Settings ***
Library  SeleniumLibrary
Suite Teardown  Close All Browsers

*** Variables ***
${URL}  https://www.brou.com.uy/

*** Keywords ***
Open Browser To Login Page
    Open Browser  ${URL}  browser=chrome
    Maximize Browser Window
    Wait Until Page Contains Element  id:username
    Wait Until Page Contains Element  id:password

Log In
    [Arguments]  ${username}  ${password}
    Input Text  id:username  ${username}
    Input Text  id:password  ${password}
    Click Button  id:login

Get Table Info
    Wait Until Page Contains Element  xpath://table[@title='Cotizaciones']
    ${table_html}=  Get Element Attribute  xpath://table[@title='Cotizaciones']  outerHTML
    Log  ${table_html}

*** Test Cases ***
Get Table Data
    Open Browser To Login Page
    Log In  demo  mode
    Get Table Info