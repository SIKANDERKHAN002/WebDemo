*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    Chrome
${URL}        https://www.saucedemo.com


*** Test Cases ***
Headless Chrome Example
    Open Headless Browser
    Open Browser   ${URL}
    #Go To ${URL}
    Capture Page Screenshot
    sleep   30s
    Close Browser

*** Keywords ***
Open Headless Browser
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    #Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --disable-gpu
    #Call Method    ${options}    add_argument    --window-size=1920,1080
    Create WebDriver    ${BROWSER}    options=${options}