*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://www.cnbc.com/markets/

*** Keywords ***
Open Browser To Page
	Open Browser  ${URL}  browser=chrome
	Wait Until Page Contains Element  xpath://*[@id='MainContentContainer']/div/div/div/div[3]/div[1]/div[1]/section/div/div[2]/div[1]

Log Table HTML
	${table_html}=  Get Element Attribute  xpath://*[@id='MainContentContainer']/div/div/div/div[3]/div[1]/div[1]/section/div/div[2]/div[1]  outerHTML
	Log  ${table_html}

*** Test Cases ***
Log Market Table HTML
	Open Browser To Page
	Log Table HTML
	Close Browser