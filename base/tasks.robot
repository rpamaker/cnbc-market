*** Settings ***
Library  SeleniumLibrary
Library  RPA.Tables
Library  RPA.FileSystem

*** Variables ***
${URL}  https://www.cnbc.com/markets/
${CSV_FILE}  market.csv

*** Test Cases ***
Open Website and Extract Market Summary
    Open Browser  ${URL}  Chrome
    ${table}=  Get Table From Web  css:.MarketSummary-marketWrapper
    ${table_as_dict}=  Convert Table To Dictionary  ${table}
    Write Table To Csv  ${table_as_dict}  ${CSV_FILE}
    Close Browser