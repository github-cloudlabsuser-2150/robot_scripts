*** Settings ***
Documentation    customer service
Library    SeleniumLibrary
Suite Setup     we are at the login page

*** Variables ***
${url}    https://automationplayground.com/crm/
${sign}    //a[@id='SignIn']
${username}    user@gmail.com
${password}    12345
${email}    samra@gmail.com
${firstname}     assamnew
${lastname}    assa
${city}    gothenburg

*** Test Cases ***
Test login
    [Documentation]    login with a correct credential
    [Tags]    login

    Given The User Is Loged In    ${username}    ${password}
    When Add Customer    ${email}    ${firstname}    ${lastname}    ${city}
    Then Customer Gets Confirmation

*** Keywords ***
We Are At The Login Page
    [Documentation]    opening the sign in page automation playground
    [Tags]    login
    Open Browser    browser=chrome
    Go To    ${url}
    Click Link    ${sign}
    Wait Until Element Is Visible    //h2[normalize-space()='Login']

The user is loged in
    [Documentation]    Giving Username and Password
    [Tags]   login
    [Arguments]    ${user}    ${pass}
    Input Text    //input[@id='email-id']    ${user}
    Input Password    //input[@id='password']    ${pass}
    Click Button    //button[@id='submit-id']
    Set Selenium Speed    1
    Wait Until Element Is Visible    //h2[normalize-space()='Our Happy Customers']
            
Add Customer
    [Documentation]    adding new customer
    [Tags]      Add Customer
    [Arguments]    ${email1}    ${firstname2}    ${lastname3}    ${city4}
    Click Element    //a[@id='new-customer']
    Wait Until Element Is Visible    //h2[normalize-space()='Add Customer']
    Input Text    //input[@id='EmailAddress']    ${email1}
    Input Text    //input[@id='FirstName']    ${firstname2}
    Input Text    //input[@id='LastName']    ${lastname3}
    Input Text    //input[@id='City']    ${city4}
    Select From List By Index  (//select[@id='StateOrRegion'])[1]    6
    Select Radio Button    gender    female
    Select Checkbox    //input[@name='promos-name']
    Click Button    //button[normalize-space()='Submit']

Customer Gets Confirmation
    Set Selenium Speed    1
    Wait Until Element Is Visible    //div[@id='Success']

