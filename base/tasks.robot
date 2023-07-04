*** Settings ***
Library  SeleniumLibrary
Suite Teardown  Close All Browsers

*** Variables ***
${URL}  https://www.brou.com.uy/

*** Keywords ***
Open The Website And Login
    Open Browser  ${URL}  chrome
    Maximize Browser Window
    # Here you would typically have steps to log in, if necessary

Find The Table
    # Trying different XPaths
    ${xpaths}=  Create List  xpath://*[contains(text(),'Euro')]
    FOR  ${xpath}  IN  @{xpaths}
        Wait Until Page Contains Element  ${xpath}  timeout=30
        ${element_exists}=  Run Keyword And Return Status  Page Should Contain Element  ${xpath}
        IF  ${element_exists}
            ${parent_xpath}=  Set Variable  ${xpath}/../..
            ${parent_html}=  Get Element Attribute  ${parent_xpath}  outerHTML
            Log  ${parent_html}
            EXIT FOR LOOP
        END
    END

*** Test Cases ***
Test Case 1
    Open The Website And Login
    Find The Table