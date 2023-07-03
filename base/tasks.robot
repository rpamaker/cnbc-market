*** Settings ***
Library           Collections

*** Variables ***
${VAR1}           1
${VAR2}           2

*** Test Cases ***
Test
    ${result}=    Set Variable If    '${VAR1}'=='${VAR2}'    true    false
    Log    ${result}
