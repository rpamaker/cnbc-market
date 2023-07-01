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
    FOR  ${row}  IN  @{rows[:-1]}
        ${name}=  Get Text  css:.MarketSummary-marketLink
        ${last}=  Get Text  css:.MarketSummary-last
        ${change}=  Get Text  css:.MarketSummary-change
        ${percent_change}=  Get Text  css:.MarketSummary-changePercent
        Append To List  ${data}  ${name},${last},${change},${percent_change}
    END
    ${csv_data}=  Catenate  SEPARATOR=\n  @{data}
    Create File  market.csv  ${csv_data}
    Close Browser