*** Settings ***
Library      RequestsLibrary
Library      Collections
Library    JSONLibrary
Resource    ../Resources/Config/Enviroment.robot
Resource    ../Resources/Variables/BookingVariables.robot
Variables   ../Resources/Variables/testdata.py
Library     JSONLibrary

*** Variables ***
${Booking_ENDPOINT}      /booking

*** Keywords ***
Get token
    ${body}     Create Dictionary       username=admin      password=password123
    ${auth_response}    POST        ${restfulBooker_baseUrl}/auth    json=${body}
    ...     expected_status=200
    ${bookingAuthToken}=    Set Variable    ${auth_response.json()}[token]
    Log    token is set: ${bookingAuthToken}
    [RETURN]    ${bookingAuthToken}

Get all Bookings
    create session      getBookingSession   ${restfulBooker_baseUrl}    verify=true
    # Get Request
    ${response}=     GET On Session    getBookingSession   /booking
     #Validation
    ${status_code}=     convert to string       ${response.status_code}
    should be equal     ${status_code}      200
    ${res_body}=        convert to string       ${response.content}
    should contain    ${res_body}      bookingid

Get Booking Data By Specific ID
    [Arguments]     ${id}
    create session      getBookingByIdSession   ${restfulBooker_baseUrl}    verify=true
    ${header}=          create dictionary      Accept=application/json
    ${get_response}     GET On Session     getBookingByIdSession  ${Booking_ENDPOINT}/${id}  headers=${header}
    ...     expected_status=200
    Log    Getting Booking Data response: ${get_response.content}
    Log    Successful getting data by posted booking id is ${id}
    [RETURN]    ${get_response}

Create Booking
    ${booking_dates}=    create dictionary
        ...      checkin=2024-03-14     checkout=2024-05-01

        ${body}=        Create Dictionary      firstname=Omar
     ...    lastname=Salam      totalprice=3434        depositpaid=false
     ...    bookingdates=${booking_dates}    additionalneeds=Dinner

     Create Session     POST    ${restfulBooker_baseUrl}     disable_warnings=1
     ${post_response}        POST On Session     POST    ${Booking_ENDPOINT}     json=${body}

     Status Should Be    200
     ${booking_Id}      Set Variable    ${post_response.json()}[bookingid]
     Log    Posted BookingID value is ${booking_Id}
     [RETURN]    ${booking_Id}



Delete Booking
    [Arguments]     ${id}
    ${token}=    Get token
    create session      deleteBookingSession         ${restfulBooker_baseUrl}    verify=true
    ${header}=       create dictionary   Content-Type=application/json     Cookie=token=${token}
    ${response}=     delete on session     deleteBookingSession        ${Booking_ENDPOINT}/${id}      headers=${header}




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


Reading Data From JSon File
    ${json_obj}=    Load Json From File    ${json_file_path}
    Log To Console    Start READING DATA HERE As BELOW:
    ${first_name}   Get Value From Json    ${json_obj}    $.firstname
    Should Be Equal    ${first_name[0]}    Marwa
    Log To Console      First Name is : ${first_name[0]}

    ${lastname}   Get Value From Json    ${json_obj}    $.lastname
    Should Be Equal    ${lastname[0]}    Adam
    Log To Console      Last Name is : ${lastname[0]}

    ${totalprice}   Get Value From Json    ${json_obj}    $.totalprice
    Should Be Equal As Numbers    ${totalprice[0]}    1900
    Log To Console    Total Price is : ${totalprice}

    ${depositpaid}   Get Value From Json    ${json_obj}    $.depositpaid
    Should Be Equal    ${depositpaid[0]}   False
    Log To Console      Deposit Paid : ${depositpaid[0]}

    ${bookingdates_checkin}   Get Value From Json    ${json_obj}    $.bookingdates.checkin
    Log To Console   checkout date is: ${bookingdates_checkin[0]}
    Should Be Equal    ${bookingdates_checkin[0]}    2025-09-30

    ${bookingdates_checkout}   Get Value From Json    ${json_obj}    $.bookingdates.checkout
    Log To Console   checkout date is: ${bookingdates_checkout[0]}
    Should Be Equal    ${bookingdates_checkout[0]}    2026-12-05
    Log To Console    Data Readed Successfully and Validated

Post Booking Using Json Data
     Create Session    booker    url=${restfulBooker_baseUrl}   headers=${headers}   disable_warnings=True
    # Create Booking
    ${response}    POST On Session    booker    /booking    json=${booking}
    Status Should Be    200
    # Log response and retrieve booking via GET
    ${response}    GET On Session    booker    /booking/${response.json()}[bookingid]
    # Assertions
    Should Be Equal    ${response.json()}[lastname]    ${booking}[lastname]
    Should Be Equal    ${response.json()}[firstname]    ${booking}[firstname]
    Should Be Equal As Numbers    ${response.json()}[totalprice]    ${booking}[totalprice]
    Should Be Equal As Strings    ${response.json()}[depositpaid]    ${booking}[depositpaid]
    Should Be Equal    ${response.json()}[bookingdates][checkin]    ${booking}[bookingdates][checkin]
    Should Be Equal    ${response.json()}[bookingdates][checkout]    ${booking}[bookingdates][checkout]
    Should Be Equal    ${response.json()}[additionalneeds]    ${booking}[additionalneeds]

