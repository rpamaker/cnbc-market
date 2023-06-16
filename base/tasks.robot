*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://www.brou.com.uy

*** Test Cases ***
Open Website and Wait
    Open Browser  ${URL}  Chrome     service_log_path=${None}
    Sleep  25
    Close Browser
