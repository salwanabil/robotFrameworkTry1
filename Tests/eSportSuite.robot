*** Settings ***
Library     SeleniumLibrary
Library     Collections
Library     RequestsLibrary
Resource    ../Resources/Config/Enviroment.robot
Resource    ../Keywords/EsportKeywords.robot

*** Variables ***
${discover_members_url}  /api/team-club/v1/members/discover-members
${organization_url}      /api/customer/v1/organization-level/org
${penality_url}          /api/penalty/v1/penalty
${accountDetails_url}    /api/uaa/user/account-details
${crm_requests_url}    /api/team-club/v1/requests/status
${penality_filterBy}    testing update Salwa club Owner

*** Test Cases ***
Log in to esport
    Login To Esport   ${adminUserName}     ${adminPassword}

#   Discover Members
Get Discover Members
    ${bearerToken}=  Login To Esport   ${adminUserName}     ${adminPassword}
    Create Session      discoverMembersSessions      ${esport_base_url}
    ${headers}=     Create Dictionary       Authorization=Bearer ${bearerToken}   Content-Type=application/json
    ${response}=    GET On Session    discoverMembersSessions       ${discover_members_url}  headers=${headers}
     #Validations
    ${status_code}=     convert to string       ${response.status_code}
    should be equal     ${status_code}      200
    Log To Console    Status Code is : ${response.status_code}
    Log To Console   Response Contents are : ${response.content}
    Log To Console   Response Headers are : ${response.headers}

#   eSport Organization structure
Get eSport Organization structure
    ${bearerToken}=  Login To Esport   ${adminUserName}     ${adminPassword}
    Create Session      discoverMembersSessions      ${esport_base_url}
    ${headers}=     Create Dictionary       Authorization=Bearer ${bearerToken}    Content-Type=application/json
    ${response}=    GET On Session    discoverMembersSessions       ${organization_url}   headers=${headers}
     #Validations
    ${status_code}=     convert to string       ${response.status_code}
    should be equal     ${status_code}      200
    Log To Console    Status Code is : ${response.status_code}
    Log To Console   Response Contents are : ${response.content}
    Log To Console   Response Headers are : ${response.headers}


#    eSport Penality Management - Penalities list
Get eSport Penality Management - Penalities list
    ${bearerToken}=  Login To Esport   ${adminUserName}     ${adminPassword}
    Create Session      PenalitySessions      ${esport_base_url}
    ${headers}=     Create Dictionary       Authorization=Bearer ${bearerToken}    Content-Type=application/json
    ${response}=    GET On Session      PenalitySessions       ${penality_url}     headers=${headers}
     #Validations
    ${status_code}=     convert to string       ${response.status_code}
    should be equal     ${status_code}      200
    Log To Console    Status Code is : ${response.status_code}
    Log To Console   Response Contents are : ${response.content}
    Log To Console   Response Headers are : ${response.headers}

#   eSport Penality Management - Penalities Filtered By
Get eSport Penality Management - Penalities Filtered By Name
    ${bearerToken}=  Login To Esport   ${adminUserName}     ${adminPassword}
    ${penality_filter_url}=    Set Variable    ${penality_url}?searchableValue=${penality_filterBy}
    Create Session      PenalitySessions      ${esport_base_url}
    ${headers}=     Create Dictionary       Authorization=Bearer ${bearerToken}    Content-Type=application/json
    ${response}=    GET On Session   PenalitySessions    ${penality_filter_url}   headers=${headers}
     #Validations
    ${status_code}=     convert to string       ${response.status_code}
    should be equal     ${status_code}      200
    Log To Console    Status Code is : ${response.status_code}
    Log To Console   Response Contents are : ${response.content}
    Log To Console   Response Headers are : ${response.headers}

#   eSport Account-Details - list
Get eSport Account-Details
    ${bearerToken}=  Login To Esport   ${adminUserName}     ${adminPassword}
    Create Session      accountDetailsSession      ${esport_base_url}
    ${headers}=     Create Dictionary       Authorization=Bearer ${bearerToken}    Content-Type=application/json
    ${response}=   GET On Session  accountDetailsSession       ${accountDetails_url}    headers=${headers}
     #Validations
    ${status_code}=     convert to string       ${response.status_code}
    should be equal     ${status_code}      200
    Log To Console    Status Code is : ${response.status_code}
    Log To Console   Response Contents are : ${response.content}
    Log To Console   Response Headers are : ${response.headers}

#   eSport CRM - list
Get eSport CRM
    ${bearerToken}=  Login To Esport   ${adminUserName}     ${adminPassword}
    Create Session      CRMSession      ${esport_base_url}
    ${headers}=     Create Dictionary       Authorization=Bearer ${bearerToken}    Content-Type=application/json
    ${response}=    GET On Session   CRMSession       ${crm_requests_url}    headers=${headers}
     #Validations
    ${status_code}=     convert to string       ${response.status_code}
    should be equal     ${status_code}      200
    Log To Console    Status Code is : ${response.status_code}
    Log To Console   Response Contents are : ${response.content}
    Log To Console   Response Headers are : ${response.headers}