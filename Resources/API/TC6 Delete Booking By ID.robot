*** Settings ***
Library      RequestsLibrary
Library      Collections
Library      String
Resource    ../Config/App_Preferences.robot
Resource    ../Keywords/BookingKeywords.robot


*** Test Cases ***
TC7_ Delete Booking by passing booking ID
    create session      deleteBookingSession         ${restfulBooker_baseUrl}    verify=true
    ${header}=       create dictionary   Content-Type=application/json      Authorization=${basic_token_for_delete}
    ${response}=     delete on session     deleteBookingSession        /booking/${booking_id_for_delete}      headers=${header}

    #Validation
    ${status_code}=     convert to string       ${response.status_code}
    should be equal     ${status_code}      201
    log to console     ${status_code}

    ${res_body}=        convert to string       ${response.content}
    should contain    ${res_body}      Created