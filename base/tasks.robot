*** Settings ***
Library  SeleniumLibrary
Library  Collections
Library  OperatingSystem

*** Variables ***
${URL}  https://finance.yahoo.com/
${TABLE_XPATH}  //*[@id='data-util-col']/section[3]/table
${CSV_FILE}  market.csv

*** Tasks ***
Open Browser To Page
    Open Browser  ${URL}  browser=firefox
    Maximize Browser Window
    Wait Until Page Contains Element  ${TABLE_XPATH}
    ${table_as_list}=  Get Table As List  ${TABLE_XPATH}
    Log  ${table_as_list}
    ${header}=  Get From List  ${table_as_list}  0
    Remove From List  ${table_as_list}  0
    ${csv_data}=  Create List
    Append To List  ${csv_data}  ${header}
    FOR  ${row}  IN  @{table_as_list}
        Append To List  ${csv_data}  ${row}
    END
    Create File  ${CSV_FILE}  ${csv_data}
    Close Browser