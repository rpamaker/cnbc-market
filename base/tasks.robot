*** Settings ***
Library           SeleniumLibrary

*** Test Cases ***
Open Browser
    Open Browser    https://www.rpamaker.com    chrome
    Log    HIA
    Sleep           15s
    Close Browser