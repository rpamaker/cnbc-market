*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://www.cnbc.com/markets/
${CSV_FILE}  market.csv

*** Keywords ***
Open The Browser To The Market Page
    Open Browser  ${URL}  browser=chrome
    Maximize Browser Window

Get Market Summary Data
    @{market_data}=  Create List
    FOR  ${i}  IN RANGE  1  11
        ${name}=  Get Text  xpath://*[@class='MarketSummary-marketWrapper']/div[${i}]/a
        ${last}=  Get Text  xpath://*[@class='MarketSummary-marketWrapper']/div[${i}]/span[1]
        ${chg}=  Get Text  xpath://*[@class='MarketSummary-marketWrapper']/div[${i}]/span[2]
        ${pct_chg}=  Get Text  xpath://*[@class='MarketSummary-marketWrapper']/div[${i}]/span[3]
        ${row}=  Create List  ${name}  ${last}  ${chg}  ${pct_chg}
        Append To List  ${market_data}  ${row}
    END
    [Return]  ${market_data}

Write Data To CSV
    [Arguments]  @{data}
    Create File  ${CSV_FILE}  Name,Last,CHG,% CHG
    FOR  ${row}  IN  @{data}
        Append To Csv File  ${CSV_FILE}  ${row}
    END

*** Test Cases ***
Market Summary Test Case
    Open The Browser To The Market Page
    ${market_summary_data}=  Get Market Summary Data
    Write Data To CSV  @{market_summary_data}
    Close Browser