*** Settings ***
Library      RequestsLibrary
Resource     ../Variables/BookingVariables.robot
Resource    ../Config/App_Preferences.robot



*** Test Cases ***
TC2_ Booking - GetBookingByBooking By Id
    create session      getBookingSession   ${restfulBooker_baseUrl}   verify=true
    # Get Request
    ${response}=     get on session     getBookingSession   /booking/${BookingID}

     #Validations
    ${status_code}=     convert to string       ${response.status_code}
    should be equal     ${status_code}      200

    ${res_body}=        convert to string       ${response.content}
    should contain    ${res_body}      firstname
