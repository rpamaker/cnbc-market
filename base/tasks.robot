*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${URL}            http://www.rpamaker.com
${BROWSER}        Chrome

*** Test Cases ***
Open RPAMaker Website
    Open Browser    ${URL}    ${BROWSER}
    Sleep    5 seconds
    Close Browser