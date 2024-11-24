url = "https://restful-booker.herokuapp.com"
headers = {'Content-Type': 'application/json'}
auth = {'username': 'admin', 'password': 'password123'}
booking = {
    "firstname" : "Marwa",
    "lastname" : "Sami",
    "totalprice" : 234,
    "depositpaid" : True,
    "bookingdates" : {
        "checkin" : "2023-09-20",
        "checkout" : "2024-12-15"
    },
    "additionalneeds" : "Dinner"
}