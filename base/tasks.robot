*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://www.brou.com.uy

*** Test Cases ***
Open Website and Wait
    Open Browser  ${URL}  Chrome
    Sleep  25
    Close Browser
