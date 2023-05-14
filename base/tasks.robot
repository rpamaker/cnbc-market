*** Settings ***
Library           SeleniumLibrary

*** Test Cases ***
Open Browser
    Open Browser    https://www.rpamaker.com    chrome
    Sleep           5s
    Close Browser