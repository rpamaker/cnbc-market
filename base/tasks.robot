*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}  https://finance.yahoo.com/

*** Keywords ***
Open Browser To Page
	Open Browser  ${URL}  browser=chrome
	Wait Until Page Contains Element  xpath://*[@id='data-util-col']/section[3]/table

Log Table HTML
	${table_html}=  Get Element Attribute  xpath://*[@id='data-util-col']/section[3]/table  outerHTML
	Log  ${table_html}

*** Test Cases ***
Log Yahoo Finance Table HTML
	Open Browser To Page
	Log Table HTML
	Close Browser