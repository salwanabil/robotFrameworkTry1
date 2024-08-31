*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ../Config/App_Preferences.robot


*** Test Cases ***
TC1_ Booking - Get All Booking IDs
    create session      getBookingSession   ${restfulBooker_baseUrl}    verify=true
    # Get Request
    ${response}=     GET On Session    getBookingSession   /booking

     #Validation
    ${status_code}=     convert to string       ${response.status_code}
    should be equal     ${status_code}      200

    ${res_body}=        convert to string       ${response.content}
    should contain    ${res_body}      bookingid
