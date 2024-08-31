*** Settings ***
Library      RequestsLibrary
Library    JSONLibrary

*** Variables ***
${restfulBooker_url}    https://restful-booker.herokuapp.com

*** Test Cases ***
BookingAuth - CreateToken
    ${body}     Create Dictionary       username=admin      password=password123

    ${auth_response}    POST        ${restfulBooker_url}/auth    json=${body}
    ...     expected_status=200

    ${bookingAuthToken} =    Evaluate   json.loads("""${auth_response.content}""")      json

    Set Suite Variable    ${token}    ${bookingAuthToken}
#    Log    ${token}