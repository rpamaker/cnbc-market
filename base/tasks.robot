*** Settings ***
Library  SeleniumLibrary
Library  Collections
Library  CSVLibrary

*** Variables ***
${URL}  https://www.cnbc.com/markets/
${CSV_FILE}  market.csv

*** Keywords ***
Open Browser To Page
	Open Browser  ${URL}  browser=chrome
	Wait Until Page Contains Element  xpath://*[@id='MainContentContainer']/div/div/div/div[3]/div[1]/div[1]/section/div/div[2]/div[1]

Get Table Data
	${rows}=  Get WebElements  xpath://*[@id='MainContentContainer']/div/div/div/div[3]/div[1]/div[1]/section/div/div[2]/div[1]/div
	${data}=  Create List
	FOR  ${row}  IN  @{rows}
		${name}=  Get Text  ${row}/a
		${last}=  Get Text  ${row}/span[1]
		${chg}=  Get Text  ${row}/span[2]
		${pct_chg}=  Get Text  ${row}/span[3]
		${row_data}=  Create List  ${name}  ${last}  ${chg}  ${pct_chg}
		Append To List  ${data}  ${row_data}
	END
	[Return]  ${data}

Write Data To CSV
	[Arguments]  ${data}
	Create CSV File  ${CSV_FILE}  ${data}

*** Test Cases ***
Get And Save Market Table Data
	Open Browser To Page
	${data}=  Get Table Data
	Write Data To CSV  ${data}
	Close Browser