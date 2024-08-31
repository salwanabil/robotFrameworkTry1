*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     OperatingSystem
Resource    ../Config/App_Preferences.robot
Resource    ../Keywords/BookingKeywords.robot


*** Variables ***
${token_t}    ee3ba312a3be642

*** Test Cases ***
Post Booking Using Json Data
#    ${auth}     Create List     admin       password123
#     Create Session     mybookersession     ${restfulBooker_baseUrl}    auth=${auth}    verify=None     disable_warnings=1
     Create Session     mybookersession     ${restfulBooker_baseUrl}    verify=None     disable_warnings=1
     ${headers}     Create Dictionary       Authorization=${token_t}     Content-Type=application/json
#     ${headers}     Create Dictionary   Content-Type=application/json
     ${req_body}    Load Json From File     ${json_file_path}
     Log To Console     ${req_body}

     ${post_response}        POST On Session     mybookersession     ${Booking_ENDPOINT}    data=${req_body}    headers=${headers}
#     ${post_response}        POST On Session    mybookersession     ${Booking_ENDPOINT}    data=${req_body}
     Log To Console    ${post_response.status_code}
     Log To Console    ${post_response.content}


#
#    ${json_obj}=    Load Json From File    ${json_file_path}
#    Log To Console    READING DATA HERE BELOW:
#    ${first_name}   Get Value From Json    ${json_obj}    $.firstname
#    Should Be Equal    ${first_name[0]}    Jim sn
#    Log To Console      First Name is : ${first_name[0]}
#
#    ${lastname}   Get Value From Json    ${json_obj}    $.lastname
#    Should Be Equal    ${lastname[0]}    Brown sn
#    Log To Console      Last Name is : ${lastname[0]}
#
#    ${totalprice}   Get Value From Json    ${json_obj}    $.totalprice
#    Should Be Equal As Numbers    ${totalprice[0]}    900
#    Log To Console    Total Price is : ${totalprice}
#
#    ${depositpaid}   Get Value From Json    ${json_obj}    $.depositpaid
#    Should Be Equal    ${depositpaid[0]}   True
#    Log To Console      Deposit Paid : ${depositpaid[0]}
#   bookingdates.checkin
#    ${bookingdates_checkin}   Get Value From Json    ${json_obj}    $.bookingdates.checkin
#    Log To Console   checkout date is: ${bookingdates_checkin[0]}
#    Should Be Equal    ${bookingdates_checkin[0]}    2018-01-01
#
#    ${bookingdates_checkout}   Get Value From Json    ${json_obj}    $.bookingdates.checkout
#    Log To Console   checkout date is: ${bookingdates_checkout[0]}
#    Should Be Equal    ${bookingdates_checkout[0]}    2019-01-01