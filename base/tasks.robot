*** Settings ***
Library  SeleniumLibrary
Library  RPA.Tables

*** Variables ***
${URL}  https://www.cnbc.com/world/?region=world
${TABLE_XPATH}  //*[@id="HomePageInternational-MarketsModule-13"]/section[2]/section[1]/div[1]/div/div/div[1]/div/table
${CSV_FILE_PATH}  data/market.csv

*** Tasks ***
Open Website and Get Table Information
    Open Browser  ${URL}  Chrome
    Wait Until Page Contains Element  ${TABLE_XPATH}  timeout=10
    ${attempts}=  Set Variable  0
    FOR  ${attempts}  IN RANGE  4
        ${rows}=  Get WebElements  ${TABLE_XPATH}/tbody/tr
        ${row_count}=  Get Length  ${rows}
        Exit For Loop If  '${row_count}' > '1'
        Sleep  5
    END
    ${table_data}=  Create List
    FOR  ${row}  IN  @{rows}
        ${columns}=  Get WebElements  ${row}/td
        ${column_count}=  Get Length  ${columns}
        Exit For Loop If  '${column_count}' > '1'
        ${row_data}=  Create List
        FOR  ${column}  IN  @{columns}
            ${cell_data}=  Get Text  ${column}
            Append To List  ${row_data}  ${cell_data}
        END
        Append To List  ${table_data}  ${row_data}
    END
    ${table}=  Create Table  ${table_data}
    Write table to CSV  ${table}  ${CSV_FILE_PATH}
    Log  ${table_data}
    Close Browser