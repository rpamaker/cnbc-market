*** Settings ***
Library  SeleniumLibrary
Suite Teardown  Close All Browsers

*** Variables ***
${URL}  https://www.brou.com.uy/

*** Keywords ***
Open The Website And Login
    Open Browser  ${URL}  chrome
    Maximize Browser Window
    # Here you would typically have steps to log in, if necessary

Find The Table
    Wait Until Page Contains Element  xpath://*[@title='Cotizaciones']  timeout=30
    ${table_xpath}=  Set Variable  xpath://*[@title='Cotizaciones']
    ${table_html}=  Get Element Attribute  ${table_xpath}  outerHTML
    Log  ${table_html}

*** Test Cases ***
Test Case 1
    Open The Website And Login
    Find The Table