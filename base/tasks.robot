*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  http://www.santander.com.uy

*** Test Cases ***
Open Website and Wait
    Open Browser  ${URL}  Chrome
    Wait Until Page Contains Element  xpath=//button[text()='Ingresar']  30s
    Sleep  5s
    Close Browser