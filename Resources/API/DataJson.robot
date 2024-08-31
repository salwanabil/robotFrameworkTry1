*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ../Config/App_Preferences.robot
Resource    ../Keywords/BookingKeywords.robot
Variables   ../Variables/testdata.py

*** Test Cases ***
Post Booking Using Json Data
     Create Session    booker    url=${url}    headers=${headers}   disable_warnings=True
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