*** Settings ***
Library           SeleniumLibrary

*** Test Cases ***
Open Browser
    Open Browser    https://www.google.com    chrome
    Log    HIA
    Sleep           25s
    Close Browser