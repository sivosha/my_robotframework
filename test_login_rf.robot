*** Settings ***
Library  SeleniumLibrary
Documentation        Suite description #automated tests for scout website


*** Variables ***
${LOGIN URL}            https://scouts.futbolkolektyw.pl/en/
${BROWSER}              Chrome
${SIGNINBUTTON}         xpath=//*[text()= 'Sign in']
${EMAILINPUT}           xpath=//input[@id='login']
${PASSWORDINPUT}        xpath=//*[@id='password']
${PAGELOGO}             xpath=//h5
${SIGNOUT}              xpath=//*[contains(@d, 'M13')]/../../..
${ADDPLAYER}            xpath=//*[text()='Add player']/../..
${NAMEINPUT}            xpath=//*[@name ='name']
${SURNAMEINPUT}         xpath=//*[@name ='surname']
${AGEINPUT}             xpath=//*[@name ='age']
${POSITIONINPUT}        xpath=//*[@name ='mainPosition']
${PREVIOUSCLUB}         xpath=//*[@name ='exClub']
${SUBMITBUTTON}         xpath=//*[@type='submit']

${DROPDOWNLANGUAGE}     xpath=//*[@aria-haspopup='listbox']
${LISTLANGUAGE}         xpath=//ul[@role='listbox']
${WRONGPASSTEXT}        xpath=//a

${DROPDOWNLANGCHOOSE}   xpath=//*[@data-value = 'pl']
${DASHBOARDLANGUAGE}    xpath=//*[contains(@d, 'M12.')]/../../..

*** Test Cases ***
Login to the system
    Open login page
    Type in email
    Type in password
    Click on the Sign In button
    Assert dashboard
    [Teardown]  close browser

Log out of the system
    Open login page
    Type in email
    Type in password
    Click on the Sign In button
    Click on the Log Out
    Assert loginpage
    [Teardown]  Close Browser

Add new player
    Open login page
    Type in email
    Type in password
    Click on the Sign In button
    Click on Add player
    Assert addPlayerPage
    Type in Name
    Type in Surname
    Type in Age
    Type in Main position
    Type in Previous club
    Click on the Submit button
    Assert addplayer
    [Teardown]  Close Browser

Change language via dashboard
    Open login page
    Type in email
    Type in password
    Click on the Sign In button
    Click on the language
    Assert dashboardlang
    [Teardown]  Close Browser

Change language via dropdown
    Open login page
    Select language
    Assert dropdownlang
    [Teardown]  Close Browser


*** Keywords ***
Open login page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be     Scouts panel - sign in
Type in email
    Input Text   ${EMAILINPUT}   user07@getnada.com
Type in password
    Input Text  ${PASSWORDINPUT}    Test-1234
Click on the Sign In button
    Click Element   xpath=//*[text()= 'Sign in']
Assert dashboard
    Wait Until Element Is Visible   (//h6)[1]   10
#    Title should be     Scouts panel
    title should be     PANEL SKAUTINGOWY
    Capture Page Screenshot  alert_dashboard.png
Click on the Log out
    wait until element is visible   ${SIGNOUT}  30
    Click Element   ${SIGNOUT}
Select language
    Click Element   ${DROPDOWNLANGUAGE}
    wait until element is visible   ${LISTLANGUAGE}
    Click Element   ${DROPDOWNLANGCHOOSE}
Assert loginpage
    Wait Until Element Is Visible   ${PAGELOGO}
    Title should be     Scouts panel - sign in
    Capture Page Screenshot  alert_loginpage.png
Assert addPlayerPage
    Wait Until Element Is Visible   ${NAMEINPUT}
    Title should be     Add player
Assert dropdownlang
    wait until element is visible   ${PAGELOGO}
    Element Text should be     ${WRONGPASSTEXT}     Przypomnij hasło
    Capture Page Screenshot  alert_dropdownlang.png
Click on Add player
    wait until element is visible   ${ADDPLAYER}    40
    Click Element   ${ADDPLAYER}
Type in name
    Input Text  ${NAMEINPUT}  Name
Type in surname
    Input Text  ${SURNAMEINPUT}     Surname
Type in age
    Input Text  ${AGEINPUT}     07/07/2007
Type in Main position
    Input Text  ${POSITIONINPUT}    first
Type in Previous club
    Input Text  ${PREVIOUSCLUB}     none
Click on the Submit button
    Click Element   ${SUBMITBUTTON}
Assert addplayer
    wait until element is not visible   ${ADDPLAYER}     40
    Element Text should be     //span[text()='Name Surname']  Name Surname
    Capture Page Screenshot  alert_addplayer.png
Click on the language
    wait until element is visible   ${DASHBOARDLANGUAGE}    10
    Click Element   ${DASHBOARDLANGUAGE}
Assert dashboardlang
    Element Text should be     ${SIGNOUT}   Wyloguj się
    Capture Page Screenshot  alert_dashboardlang.png
