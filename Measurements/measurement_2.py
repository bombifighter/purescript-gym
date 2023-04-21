import requests
import time

if __name__ == '__main__':

    headers = {
    'Content-Type': 'text/plain'
    }

    url = "http://localhost:3000/guest/insertGuest"
    payload = "{\"id\":1 , \"name\": \"Abel\", \"gender\":\"male\", \"bdate\": \"2002.03.11\", \"phone\":\"+36301112233\", \"email\":\"abel@mail.com\"}"
    response = requests.request("POST", url, headers=headers, data=payload)

    start = time.time()
##########################################

    for i in range(10):
        url = "http://localhost:3000/guest/checkin"
        payload = "{\"guestId\": 1, \"gender\": \"male\", \"date\": \"2023/04/21\", \"time\": \"00:40\" }"
        response = requests.request("POST", url, headers=headers, data=payload)

        url = "http://localhost:3000/guest/checkout"
        payload = "{\"guestId\": 1, \"LockerId\": 1, \"gender\": \"male\", \"dateTime\": \"2023/04/21\" }"
        response = requests.request("POST", url, headers=headers, data=payload)


##########################################
    end = time.time()
    time = end - start

    url = "http://localhost:3000/guest/deleteGuest/1"
    response = requests.request("DELETE", url, headers=headers, data=payload)

    print(time)
