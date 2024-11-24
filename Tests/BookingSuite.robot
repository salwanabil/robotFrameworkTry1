*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ../Resources/Config/Enviroment.robot
Resource    ../Keywords/BookingKeywords.robot

*** Test Cases ***
TC1_ Booking - Get All Booking IDs
   Get all Bookings

TC2_ Booking - GetBookingByBooking By Id
    # Get Request
    ${response}=    Get Booking Data By Specific ID   ${global_booking_id}
     #Validations
    ${status_code}=     convert to string       ${response.status_code}
    should be equal     ${status_code}      200
    ${res_body}=        convert to string       ${response.content}
    should contain    ${res_body}      firstname

TC3_ Booking - CreateBooking Then Verify Posted Data Are Get
   ${booking_Id}=   Create Booking
   Log    Verifying that posted data are then fetched by created booking id: ${booking_Id}
   Get Booking Data By Specific ID    ${booking_Id}

TC4_ Delete Booking by passing booking ID
    ${booking_Id}=   Create Booking
    Get Booking Data By Specific ID     ${booking_Id}
    Delete Booking   ${booking_Id}

TC_5_Reading Json Data
    Reading Data From JSon File

TC_6_Create Booking From Json Data
    Post Booking Using Json Data
