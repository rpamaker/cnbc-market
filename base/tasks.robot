*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  http://www.santander.com.uy

*** Test Cases ***
Open Website and Wait
    Open Browser  ${URL}  Chrome
    Sleep  10s
    Close Browser