*** Settings ***
Library  SeleniumLibrary
Library  Collections

*** Variables ***
${URL}  https://www.cnbc.com/markets/
${BROWSER}  chrome

*** Tasks ***
Open Browser To CNBC
    Open Browser  ${URL}  ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element  css:.MarketSummary-marketWrapper
    ${rows}=  Get WebElements  css:.MarketSummary-marketWrapper > div:not(:last-child)
    @{data}=  Create List
    FOR  ${row}  IN  @{rows}
        ${name}=  Get Text  ${row} > a
        ${last}=  Get Text  ${row} > .MarketSummary-last
        ${change}=  Get Text  ${row} > .MarketSummary-change
        ${percent_change}=  Get Text  ${row} > .MarketSummary-changePercent
        ${row_data}=  Catenate  SEPARATOR=,  ${name}  ${last}  ${change}  ${percent_change}
        Append To List  ${data}  ${row_data}
    END
    ${csv_data}=  Catenate  SEPARATOR=\n  @{data}
    Create File  market.csv  ${csv_data}
    Close Browser