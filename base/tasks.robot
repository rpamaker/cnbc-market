*** Settings ***
Library  SeleniumLibrary
Suite Teardown  Close All Browsers

*** Variables ***
${URL}  https://www.cnbc.com/world/?region=world
${TABLE_XPATH}  //*[@id="HomePageInternational-MarketsModule-13"]/section[2]/section[1]/div[1]/div/div/div[1]/div/table

*** Test Cases ***
Open Website and Get Table Information
    Open Browser  ${URL}  Chrome
    Wait Until Page Contains Element  ${TABLE_XPATH}  timeout=10
    ${table_html}=  Get Element Attribute  ${TABLE_XPATH}  outerHTML
    Log  ${table_html}
    Close Browser