*** Settings ***
Library  SeleniumLibrary
Suite Teardown  Close All Browsers

*** Variables ***
${URL}  https://www.marketwatch.com/
${TABLE_XPATH}  /html/body/section[1]/div[2]/div/div[2]/div/div[1]/table

*** Tasks ***
Open Website and Get Market Prices
    Open Browser  ${URL}  Chrome
    Wait Until Page Contains Element  ${TABLE_XPATH}  timeout=30
    ${table_data}=  Get Table Data  ${TABLE_XPATH}
    Log  ${table_data}

*** Keywords ***
Get Table Data
    [Arguments]  ${table_xpath}
    @{all_row_data}=  Create List
    ${rows}=  Get WebElements  ${table_xpath}
    ${row_count}=  Get length  ${rows}
    FOR  ${index}  IN RANGE  0  ${row_count}
        ${row_data}=  Create Dictionary
        TRY
            ${column1}=  Get Text  ${table_xpath}/tr[${index + 1}]/td[1]
            ${column2}=  Get Text  ${table_xpath}/tr[${index + 1}]/td[2]
        EXCEPT
            ${column1}=  ${column2}=  N/A
        END
        Set To Dictionary  ${row_data}  Column_1  ${column1}
        Set To Dictionary  ${row_data}  Column_2  ${column2}
        Append To List  ${all_row_data}  ${row_data}
    END
    [Return]  ${all_row_data}