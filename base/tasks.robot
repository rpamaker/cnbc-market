*** Settings ***
Library           SeleniumLibrary

*** Test Cases ***
Open Browser
    Open Browser    https://www.sonda.com/    chrome
    Log    HIA
    Sleep           25s
    Close Browser