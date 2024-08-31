*** Settings ***
Library      RequestsLibrary
Resource    ../Keywords/BookingKeywords.robot

*** Test Cases ***
Test POST Request Booking - CreateBooking Then Verify Posted Data Are Get
   Test POST Request Create Booking

   Log    Verifying that posted data are then fetched by created booking id: ${global_booking_id}

   Test Get Booking Data By Specific ID     ${global_booking_id}


#    robot -d results .