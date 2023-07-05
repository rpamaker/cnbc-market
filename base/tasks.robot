*** Settings ***
Library  SeleniumLibrary
Library  Collections
Library  RPA.Tables
Suite Teardown  Close All Browsers

*** Variables ***
${URL}  https://www.cnbc.com/world/?region=world
${TABLE_XPATH}  //*[@id="HomePageInternational-MarketsModule-13"]/section[2]/section[1]/div[1]/div/div/div[1]/div/table
${CSV_FILE_PATH}  data/market.csv

*** Test Cases ***
Open Website and Get Table Information
    Open Browser  ${URL}  Chrome
    Wait Until Page Contains Element  ${TABLE_XPATH}  timeout=10
    ${attempts}=  Set Variable  0
    FOR  ${attempts}  IN RANGE  4
        ${rows}=  Get WebElements  ${TABLE_XPATH}/tbody/tr
        ${row_count}=  Get Length  ${rows}
        Exit For Loop If  ${row_count} > 1
        Sleep  5
    END
    ${table_data}=  Create List
    FOR  ${row}  IN  @{rows}
        ${columns}=  Get WebElements  ${row}/td
        ${row_data}=  Create List
        FOR  ${column}  IN  @{columns}
            ${cell_data}=  Get Text  ${column}
            Append To List  ${row_data}  ${cell_data}
        END
        Append To List  ${table_data}  ${row_data}
    END
    Write table to CSV  ${table_data}  ${CSV_FILE_PATH}
    Log  ${table_data}
    Close Browser