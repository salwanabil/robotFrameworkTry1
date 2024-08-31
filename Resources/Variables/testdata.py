url = "https://restful-booker.herokuapp.com"
headers = {'Content-Type: application/json'}
auth = {'username' : 'admin', 'password' : 'password123'}
booking = {
    "firstname" : "Jim",
    "lastname" : "Brown",
    "totalprice" : 456,
    "depositpaid" : True,
    "bookingdates" : {
        "checkin" : "2018-01-01",
        "checkout" : "2022-01-01"
    },
    "additionalneeds" : "Breakfast"
}

