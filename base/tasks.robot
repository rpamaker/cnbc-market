*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://www.rpamaker.com

*** Test Cases ***
Open Website and Wait
    Open Browser  ${URL}  Chrome
    Sleep  5s
    Close Browser