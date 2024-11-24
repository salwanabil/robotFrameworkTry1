*** Settings ***
Library      RequestsLibrary
Library      Collections
Library    JSONLibrary
Resource    ../Resources/Config/Enviroment.robot
Library     JSONLibrary

*** Variables ***
${Login_Service_Url}     /auth/realms/cust_esports.com/protocol/openid-connect/token

*** Keywords ***
Login To Esport
    [Arguments]    ${username}   ${password}
    ${body}     Create Dictionary       username=${username}      password=${password}    grant_type=password     client_id=WEB
    ${headers}      Create Dictionary   Content-Type=application/x-www-form-urlencoded      Connection=keep-alive
    Create Session      loginSessions      ${esport_base_url}      headers=${headers}      disable_warnings=True
    ${response}    POST On Session     loginSessions     ${Login_Service_Url}      data=${body}
    ...     expected_status=200
    ${esport_token}      Set Variable    ${response.json()}[access_token]
    #Log To Console    esport access Token: ${esport_token}
    [Return]    ${esport_token}


