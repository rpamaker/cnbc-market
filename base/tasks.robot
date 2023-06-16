*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://www.brou.com.uy
${CUSTOM NONE}    ${None}

*** Test Cases ***
Open Website and Wait
    Open Browser  ${URL}  Chrome     service_log_path=${CUSTOM NONE}
    Sleep  25
    Close Browser
