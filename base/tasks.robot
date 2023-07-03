*** Settings ***
Library  SeleniumLibrary
Library  Collections
Library  OperatingSystem

*** Variables ***
${URL}  https://finance.yahoo.com/
${TABLE_XPATH}  //*[@id='data-util-col']/section[3]/table
${CSV_FILE}  market.csv

*** Keywords ***
Open Browser To Page
	Open Browser  ${URL}  browser=firefox
	Maximize Browser Window
	Wait Until Page Contains Element  ${TABLE_XPATH}  timeout=30

Get Table Data
	${rows}=  Get WebElements  ${TABLE_XPATH}/tbody/tr
	${data}=  Create List
	FOR  ${row}  IN  @{rows}
		${row_data}=  Create Dictionary
		${name}=  Get Text  ${row}/td[1]
		${last_price}=  Get Text  ${row}/td[2]
		${change}=  Get Text  ${row}/td[3]
		${percent_change}=  Get Text  ${row}/td[4]
		Set To Dictionary  ${row_data}  Name  ${name}
		Set To Dictionary  ${row_data}  Last Price  ${last_price}
		Set To Dictionary  ${row_data}  Change  ${change}
		Set To Dictionary  ${row_data}  % Change  ${percent_change}
		Append To List  ${data}  ${row_data}
	END
	[Return]  ${data}

Write Data To CSV
	[Arguments]  ${data}
	${csv_data}=  Create List  Name,Last Price,Change,% Change
	FOR  ${row}  IN  @{data}
		${csv_row}=  ${row}[Name],${row}[Last Price],${row}[Change],${row}[% Change]
		Append To List  ${csv_data}  ${csv_row}
	END
	Create File  ${CSV_FILE}  ${csv_data}

*** Test Cases ***
Get And Save Market Table Data
	Open Browser To Page
	${data}=  Get Table Data
	Write Data To CSV  ${data}
	Close All Browsers