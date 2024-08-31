*** Settings ***
Library      RequestsLibrary
Library      Collections
Library    JSONLibrary
Resource    ../Config/App_Preferences.robot
Resource    ../Variables/BookingVariables.robot
Library     JSONLibrary

*** Keywords ***
Test Get Booking Data By Specific ID
    [Arguments]     ${id}
    ${get_response}     GET     ${restfulBooker_baseUrl}${Booking_ENDPOINT}/${id}
    ...     expected_status=200
    Log    Getting Booking Data response: ${get_response.json()}
    Log    Successful getting data by posted booking id is ${id}


#Test Get Booking Request To Verify
#    [Arguments]     ${id}       ${fname}    ${lname}    ${tprice}   ${checkin}
#    ...     ${checkout}
#    ${get_response}     GET     ${restfulBooker_baseUrl}${Booking_ENDPOINT}/${id}
#    ...     expected_status=200
#
#    Log    ${get_response.json()}
#    Should Be Equal    ${fname}     ${get_response.json()}[firstname]
#    Should Be Equal    ${lname}     ${get_response.json()}[lastname]
#    Should Be Equal As Numbers    ${tprice}     ${get_response.json()}[totalprice]
#    Dictionary Should Contain Sub Dictionary    ${get_response.json()}
#    ...     ${checkin}
#    Dictionary Should Contain Value    ${get_response.json()}
#    ...     ${checkout}
Set book id from post to get    ${expected_booking_id}
    ${actual_booking_id}=   Get Variable Value    ${global_booking_id}
    Should Be Equal As Strings    ${expected_booking_id}    ${actual_booking_id}

Test Get Booking Request To Verify
    [Arguments]     ${global_booking_id}     ${fname}    ${lname}    ${tprice}   ${checkin}
    ...     ${checkout}
    ${get_response}     GET     ${restfulBooker_baseUrl}${Booking_ENDPOINT}/${global_booking_id}
    ...     expected_status=200

    Log    ${get_response.json()}

    Should Be Equal    ${fname}     ${get_response.json()}[firstname]
    Should Be Equal    ${lname}     ${get_response.json()}[lastname]
    Should Be Equal As Numbers    ${tprice}     ${get_response.json()}[totalprice]
    Should Be Equal As Strings     ${checkin}   ${get_response.json()}[bookingdates][checkin]
    Should Be Equal As Strings     ${checkout}     ${get_response.json()}[bookingdates][checkout]



Test POST Request Create Booking
    ${booking_dates}=    create dictionary
        ...      checkin=2024-03-14     checkout=2024-05-01

        ${body}=        Create Dictionary      firstname=Omar
     ...    lastname=Salam      totalprice=3434        depositpaid=false
     ...    bookingdates=${booking_dates}    additionalneeds=Dinner

     Create Session     POST    ${restfulBooker_baseUrl}     disable_warnings=1
     ${post_response}        POST On Session     POST    ${Booking_ENDPOINT}     json=${body}

     Status Should Be    200
     ${booking_Id}      Set Variable    ${post_response.json()}[bookingid]
     Set Global Variable    ${global_booking_id}     ${booking_Id}
     Log    Posted BookingID value is ${global_booking_id}


#    Keyword    to Update Booking data
Test Modify Update Booking Request
    ${booking_dates}    Create Dictionary
    ...     checkin=${UPDATE_CheckIn}       checkout=${UPDATE_CheckOut}

#     &{header}   Create Dictionary   Cookie=token\=${set_token}      Content-Type=application/json; charset=utf-8     Accept=application/json

    ${body}     Create Dictionary   firstname=${UPDATE_FirstName}
    ...     lastname=${UPDATE_LastName}
    ...     totalprice=${UPDATE_TotalPrice}
    ...     depositpaid=${UPDATE_DepositPaid}
    ...     bookingdates=${booking_dates}
    ...     additionalneeds=${UPDATE_Additionalneeds}

    ${header}       Create Dictionary       Cookie=token\=${set_token}
#    ${header}   Create Dictionary   Cookie=${set_token}
    ${put_response}     PUT     ${restfulBooker_baseUrl}${Booking_ENDPOINT}     /${global_booking_id}
    ...    headers= ${header}    json=${body}    expected_status=200

#    ${final_update}     Set Variable    ${put_response.json()}
#    Set Suite Variable      ${final_update}

    Log    ${put_response.json()}
    Log To Console      UPDATED RESPONSE:    ${put_response.json()}


BookingAuth Create Token Then Allow Access
    ${body}     Create Dictionary       username=admin      password=password123

    ${auth_response}    POST        ${restfulBooker_baseUrl}/auth    json=${body}
    ...     expected_status=200

    ${bookingAuthToken} =    Evaluate   json.loads("""${auth_response.content}""")      json
    Log    ${auth_response.json()}${auth_response.json()}[token]
#    ${token}    Get Value From Json  ${auth_response.json()}[token]

    Set Suite Variable    ${set_token}    ${auth_response.json()}[token]
    Log    token is set: ${set_token}

Reading Data From JSon File
    ${json_obj}=    Load Json From File    ${json_file_path}

#    ${first_name}   Get Value From Json    ${json_obj}    $.firstname
#    Should Be Equal    ${first_name[0]}    Jim sn
#    Log To Console    ${first_name[0]}

    ${lastname}   Get Value From Json    ${json_obj}    $.lastname
    Should Be Equal    ${lastname[0]}    Brown sn
    Log To Console    ${lastname[0]}

    ${totalprice}   Get Value From Json    ${json_obj}    $.totalprice
    Should Be Equal As Numbers    ${totalprice[0]}    900
    Log To Console    ${totalprice}

    ${depositpaid}   Get Value From Json    ${json_obj}    $.depositpaid
    Should Be Equal    ${depositpaid[0]}    true
    Log To Console    ${depositpaid[0]}

    ${bookingdates}   Get Value From Json    ${json_obj}    $.bookingdates[1].checkin
    Should Be Equal    ${bookingdates[0]}    2018-01-01
    Log To Console    ${bookingdates[0]}

