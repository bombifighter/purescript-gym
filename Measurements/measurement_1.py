import requests
import time

if __name__ == '__main__':

    headers = {
    'Content-Type': 'text/plain'
    }

    start = time.time()
    for i in range(1, 1000):
        
        url = "http://127.0.0.1:3000/guest/insertGuest"
        payload = "{\"id\":1 , \"name\": \"Abel\", \"gender\":\"male\", \"bdate\": \"2002.03.11\", \"phone\":\"+36301112233\", \"email\":\"abel@mail.com\"}"
        response = requests.request("POST", url, headers=headers, data=payload)
        
        url = "http://127.0.0.1:3000/guest/updateGuest/1"
        payload = "{\"id\":1 , \"name\": \"Doma\", \"gender\":\"male\", \"bdate\": \"2002.03.11\", \"phone\":\"+36301112233\", \"email\":\"abel@mail.com\"}"
        response = requests.request("PUT", url, headers=headers, data=payload)
        
        url = "http://127.0.0.1:3000/guest/deleteGuest/1"
        response = requests.request("DELETE", url, headers=headers, data=payload)

    end = time.time()
    time = end-start

    print(time)