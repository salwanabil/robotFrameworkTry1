*** Settings ***
Library     SeleniumLibrary
Library     Collections
Library    RequestsLibrary
Resource    ../../Config/App_Preferences.robot



*** Variables ***
${base_url}     https://qa.saudiesports.sa/
${bareerToken}     Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJma1JPclNrWFZZT3FSTFl2UnNOUXdiZHFuTmoxQk1JSHMtNkVsUl9ybEswIn0.eyJleHAiOjE3MjUxMDUzNDEsImlhdCI6MTcyNTEwMTc0MSwiYXV0aF90aW1lIjoxNzI1MTAxNzQwLCJqdGkiOiI3YmFmMmJjMi02NDY5LTRlMzUtODk1Ni1lODk0OTJjYWU5MmUiLCJpc3MiOiJodHRwczovL3FhLnNhdWRpZXNwb3J0cy5zYS9hdXRoL3JlYWxtcy9jdXN0X2VzcG9ydHMuY29tIiwiYXVkIjoiYWNjb3VudCIsInN1YiI6IjBlN2FjYTk3LTQ4MWQtNDExZC1iZmQ3LWM4ZWE0OTRmMDUzNiIsInR5cCI6IkJlYXJlciIsImF6cCI6IldFQiIsIm5vbmNlIjoiMmY4MjkwM2UtZWY5Mi00ODYwLThiMjUtZGMwNjY0NDkzYzI4Iiwic2Vzc2lvbl9zdGF0ZSI6IjFkNzgxODY3LTgxNGMtNDMzYi04NDA3LTIyNzliMjdhOTk0MiIsImFjciI6IjEiLCJhbGxvd2VkLW9yaWdpbnMiOlsiKiJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsiQ19VUF9WX08iLCJDX1JfVkFTX08iLCJDX1RfVUFSX08iLCJDX1VfQkxfTyIsIkNfSU5EX0xfTyIsIkNfQ0xfTVBfTyIsIkNfVF9VQUxfTyIsIkNfUl9TRF9PIiwiQ19PX0VfTyIsIkNfSU5SX0VfTyIsIkNfRVZfTF9PIiwiQ19JTkNfU0RfTyIsIkNfVVBfRF9PIiwiQ19QQVJfQ0FOX08iLCJDX1RDX0VfTyIsIkNfQ0xfRU1ZX08iLCJDX1BORV9MX08iLCJDX0NSUV9FX08iLCJDX1RfVl9PIiwiQ19QQVJfRV9MX08iLCJDX0NMX1ZNWV9PIiwidW1hX2F1dGhvcml6YXRpb24iLCJDX1BBUl9FX08iLCJDX0lOVV9MX08iLCJDX1VfUlNNX08iLCJDX1RfTVRBX08iLCJDX0RBU19WX08iLCJDX0lOQ19SQVNfTyIsIkNfRVZSX0VfTyIsIkNfSU5UX0xfTyIsIkNfTUVfQkxfTyIsIkNfVF9EU19PIiwiQ19DTF9NQV9PIiwiQ19UV19FX08iLCJDX01FX1VOQl9PIiwiQ19NRV9EU19PIiwiQ19BUFJfRV9PIiwiQ19WX0FTX08iLCJkZWZhdWx0LXJvbGVzLWN1c3RfZXNwb3J0cy5jb20iLCJDX0FMX0VYUF9PIiwiQ19DTF9WX08iLCJDX1RfQV9PIiwiQ19FVl9FWFBfTyIsIkNfUl9WQUxfTyIsIkNfRVZfRV9PIiwiQ19UX0FSX08iLCJDX1RfRV9PIiwiQ19DTF9FWFBfTyIsIkNfQ0xfRUFMX08iLCJDX1RfRUFMX08iLCJDX1VQX0VfTyIsIkNfVVBfQV9PIiwib2ZmbGluZV9hY2Nlc3MiLCJDX0NMX0FTX08iLCJDX1VfRV9PIiwiQ19NRV9FWFBfTyIsIkNfUlNfRV9PIiwiQ19VX1VCTF9PIiwiQ19DTF9VQkxfTyIsIkNfVV9FWFBfTyIsIkNfVV9BX08iLCJDX1BORV9FX08iLCJDX1JfUkFTX08iLCJDX1RfUkNfTyIsIkNfUE5FX0FfTyIsIkNfSU5QX0xfTyIsIkNfUE5FX0NfTyIsIkNfUEFSX0xfTyIsIkNfSU5BX0xfTyIsIkNfT0JDX0FfTyIsIkNfVF9FWFBfTyIsIkNfQ0xfQkxfTyIsIkNfUEFSX0lTVV9PIiwiQ19NRV9FQVBfTyIsIkNfQ0xfQ0FMX08iLCJDX01FX1ZFUl9PIiwiQ19VX1ZfTyIsIkNfTUVfTUFfTyIsIkNfQVJDX0VfTyIsIkNfTUVfVkFMX08iLCJDX0NMX0RTX08iLCJDX0VWX0NBTl9PIiwiQ19UX0FSTF9PIiwiQ19OUl9FX08iXX0sInJlc291cmNlX2FjY2VzcyI6eyJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6Im9wZW5pZCBlbWFpbCBwcm9maWxlIiwic2lkIjoiMWQ3ODE4NjctODE0Yy00MzNiLTg0MDctMjI3OWIyN2E5OTQyIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsInVsaWQiOiI3NzUzMWEwZi05Nzc0LTRiZTktOTE3YS01MjRmNTFhMmYzMTIiLCJuYW1lIjoiVGVzdGluZyBIb290bWFpbCBzYWx3YSB0ZXN0aW5nIHVwZGF0ZSB0ZXN0aW5nIGxvbmciLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiIrMjAxMDkyNTc3ODE5IiwicmlkIjoiY3VzdF9lc3BvcnRzLmNvbSIsImdpdmVuX25hbWUiOiJUZXN0aW5nIEhvb3RtYWlsIHNhbHdhIHRlc3RpbmcgdXBkYXRlIHRlc3RpbmcgbG9uZyIsImVtYWlsIjoic2VmdGVzdHN0Y0Bob3RtYWlsLmNvbSIsImtleSI6ImN1c3RfZXNwb3J0cy5jb21fS0VZIiwiY2lkIjoiMV9TVENTX0NVU1QifQ.PIjOVvJog_X67UvFaOrvJnLO1c37tvkgc5qGvawM9AoyLZM4IbhZnI2ma1DRui9jYvFoWzOcT5TRpvXCQl09JVdFPc3dq16uODoAhw3vSlpl9lme9ts3MYQTMWm3Fxmw-EZqidByBXnIuro8EnEZK1kXPmcg4TsR2TSBXT29HQF9ttsiOTG9PPxs86wWu1jg5wHT4-LXxT6pUuy1yq3TD1f8zmim2QicrTd8YhS5PkaQxQHgDy3mpLgVieZAU3JxbIc0ag7oFqLt_bDEHr5ZvOOaqHtIUqktoSUkSXwr1hJ_Lqdlq6JilhS66MaLgMpZSxNjE18K4BqLJovs6f0DwA


*** Test Cases ***
Log in to eSports Portal
    ${body}     Create Dictionary       username=sefteststc@hotmail.com      password=P@ssw0rd

    ${auth_response}    POST        ${eSports_qa_url}/authnticate/   json=${body}
    ...     expected_status=200

    ${esportsAuthToken} =    Evaluate   json.loads("""${auth_response.content}""")      json
    Set Suite Variable    ${token}    ${esportsAuthToken}
    Log To Console   Token is : ${token}
    Log To Console    Response Contents are : ${response.content}

    Set Suite Variable    ${token}    ${esportsAuthToken}

Get Discover Members
    Create Session      discoverMembersSessions      ${base_url}
    ${headers}=     Create Dictionary       Authorization=${bareerToken}    Content-Type=application/json

    ${response}=    Get Request    discoverMembersSessions       /api/team-club/v1/members/discover-members  headers=${headers}
     #Validations
    ${status_code}=     convert to string       ${response.status_code}
    should be equal     ${status_code}      200
    Log To Console    Status Code is : ${response.status_code}
    Log To Console   Response Contents are : ${response.content}
    Log To Console   Response Headers are : ${response.headers}

Get Discover Clans
    Create Session      discoverClansSession     ${base_url}
    ${headers}=     Create Dictionary       Authorization=${bareerToken}    Content-Type=application/json

    ${response}=    POST On Session   discoverClansSession       /api/team-club/v1/teams/discover  headers=${headers}
     #Validations
#    ${status_code}=     convert to string       ${response.status_code}
#    should be equal     ${status_code}      200
    Log To Console    Status Code is : ${response.status_code}
    Log To Console   Response Contents are : ${response.content}
    Log To Console   Response Headers are : ${response.headers}