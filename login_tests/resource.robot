*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary
Library           OperatingSystem

*** Variables ***
${SERVER}           localhost:9595
${BROWSER}          Chrome
${DELAY}            0
${VALID USER}       demo
${VALID PASSWORD}   mode
${LOGIN URL}        http://${SERVER}/
${WELCOME URL}      http://${SERVER}/welcome.html
${ERROR URL}        http://${SERVER}/error.html


*** Keywords ***
Open Browser To Login Page
    Log   ${LOGIN URL}
    Log   ${SERVER}
    ${current_dir}=   Set Variable    ${CURDIR}
    ${temp_dir}=    Evaluate      tempfile.mkdtemp(dir='${current_dir}')    tempfile
    Log   ${temp_dir}
    ${options}=     Evaluate      sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
   #Call Method     ${options}    add_argument    --user-data-dir\=${temp_dir}
    #Call Method     ${options}    add_argument    --no-sandbox
    #Call Method     ${options}    add_argument    --incognito
    #Call Method     ${options}    add_argument    --ignore-certificate-errors
    #Call Method     ${options}    add_argument    --profile-root=${temp_dir}
    
    Create WebDriver    Chrome    options=${options}
    
    #Open Browser    https://www.saucedemo.com   Chrome
    #Open Browser    ${LOGIN URL}   ${BROWSER}
    
    Go To    ${LOGIN URL}
    
    Capture Page Screenshot    loginUrl.png
    #Sleep   10s
    #Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    #Login Page Should Be Open
    Capture Page Screenshot    loginUrl2.png




Login Page Should Be Open
    Title Should Be    Login Page
    

Go To Login Page
    Go To    ${LOGIN URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text    username_field    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    password_field    ${password}

Submit Credentials
    Click Button    login_button

Welcome Page Should Be Open
    Location Should Be    ${WELCOME URL}
    Title Should Be    Welcome Page


Test Teardown All
    Close All Browsers
