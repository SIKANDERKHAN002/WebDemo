*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
#${SERVER}         localhost:9595
${SERVER}          www.saucedemo.com
#${BROWSER}        Firefox
${BROWSER}        headlessfirefox
${DELAY}           0
${VALID USER}      demo
${VALID PASSWORD}    mode
${LOGIN URL}       https://${SERVER}/
${WELCOME URL}     http://${SERVER}/welcome.html
${ERROR URL}       http://${SERVER}/error.html
#${ExtraArgument}   Dell
#${OneMoreTesting}  Test
#${ThisIsThird}     Third

*** Keywords ***
Open Browser To Login Page
    Log   ${LOGIN URL}
    Log   ${SERVER}
    ${temp_dir}=    Evaluate      tempfile.mkdtemp()    tempfile
    Log   ${temp_dir}
    ${options}=     Evaluate      sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method      ${options}    add_argument    --user-data-dir=${temp_dir}
    #Call Method     ${options}    add_argument    --incognito
    Create WebDriver    Chrome    options=${options}   
    #Open Browser    https://www.saucedemo.com   Chrome
    #Open Browser    https://www.saucedemo.com   Chrome
    Go To    https://www.saucedemo.com
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

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
