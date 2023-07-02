*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://www.cnbc.com/markets/
${CSV_FILE}  market.csv

*** Keywords ***
Open Browser To Page
	Open Browser  ${URL}  browser=chrome
	Wait Until Page Contains Element  css:.MarketSummary-marketWrapper

Get Market Data
	${market_data}=  Create List
	${markets}=  Get WebElements  css:.MarketSummary-market
	FOR  ${market}  IN  @{markets}
		${name}=  Get Text  ${market} .MarketSummary-summaryColFirst
		${last}=  Get Text  ${market} .MarketSummary-summaryColSecond
		${chg}=  Get Text  ${market} .MarketSummary-summaryColThird
		${pct_chg}=  Get Text  ${market} .MarketSummary-summaryColFourth
		${row}=  Create List  ${name}  ${last}  ${chg}  ${pct_chg}
		Append To List  ${market_data}  ${row}
	END
	[Return]  ${market_data}

Write Data To CSV
	[Arguments]  ${data}
	${header}=  Create List  Name  Last  CHG  % CHG
	Create File  ${CSV_FILE}  ${header}
	Append To Csv File  ${CSV_FILE}  ${data}

*** Test Cases ***
Get And Save Market Data
	Open Browser To Page
	${data}=  Get Market Data
	Write Data To CSV  ${data}
	Close Browser