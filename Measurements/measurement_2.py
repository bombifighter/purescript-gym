import requests
import time

if __name__ == '__main__':

    headers = {
    'Content-Type': 'application/json'
    }
    
    timeSum = 0
    
    url = "http://127.0.0.1:3000/guest/insertGuest"
    payload = "{\"id\":1 , \"name\": \"Abel\", \"gender\":\"male\", \"bdate\": \"2002.03.11\", \"phone\":\"+36301112233\", \"email\":\"abel@mail.com\"}"
    response = requests.request("POST", url, headers=headers, data=payload)
    
    url = "http://127.0.0.1:3000/clubmember/insertClubMember"
    payload = "{\"id\": 1,\"guestId\": 1, \"endDate\": \"2023/04/21\" }"
    response = requests.request("POST", url, headers=headers, data=payload)

    url = "http://127.0.0.1:3000/membership/insertMembership"
    payload = "{\"id\": 1,\"guestId\": 1, \"membershipTypeId\": 1,\"endDate\": \"2023/10/01\",\"occasionsLeft\": -1 }"
    response = requests.request("POST", url, headers=headers, data=payload)

    for i in range(5):

        start = time.time()

        for j in range(1,10):
            url = "http://127.0.0.1:3000/guest/checkin"
            payload = "{\"guestId\": 1, \"gender\": \"male\", \"date\": \"2023/04/21\", \"time\": \"00:40\" }"
            response = requests.request("POST", url, headers=headers, data=payload)

            url = "http://127.0.0.1:3000/guest/checkout"
            payload = "{\"guestId\": 1, \"lockerId\": 1, \"gender\": \"male\", \"dateTime\": \"2023/04/21 : 00:41\" }"
            response = requests.request("POST", url, headers=headers, data=payload)

        end = time.time()
        timeSum = timeSum + (end - start)

    
    url = "http://127.0.0.1:3000/guest/deleteGuest/1"
    response = requests.request("DELETE", url, headers=headers)

    print(timeSum/5)
