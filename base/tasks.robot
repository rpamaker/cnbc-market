*** Settings ***
Documentation   Template robot main suite.
Library         SeleniumLibrary
Library         Collections
Library         libraries/ExampleHelper.py
Resource        keywords/keywords.robot


*** Keywords ***
Example Keyword
    Open Browser     https://www.legalitas.com/    Chrome
    Sleep    15


*** Tasks ***
Example Task
    Example Keyword
    Example Robot Keyword



