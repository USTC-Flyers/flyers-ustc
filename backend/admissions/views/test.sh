curl 'http://localhost:8080/api/user_profile/1/' \
  -X 'PATCH' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: zh-CN,zh;q=0.9' \
  -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkwMDA3MzMyLCJpYXQiOjE2ODk5NDY2MjMsImp0aSI6IjBlNWYzNjZlODU5ODQ2YWM4YjU1ZjdmMDgwYmEwZjc0IiwidXNlcl9pZCI6MX0.LZQkkvKnN5OmfdH_l7s581CvljZaXQpGxSnpBA9p8p4' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Cookie: flyers_refresh_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY5MTY3NDYyMywiaWF0IjoxNjg5OTQ2NjIzLCJqdGkiOiIyMjY1ZDY5ZGM1ZWM0ZTYyOGM3ZTc2ZThhMzgyMjM0OSIsInVzZXJfaWQiOjF9.vXey56EZbJdEKa-H4z-Fl8QtzjEoExSx8UNh3ljz8Ws; flyers_token=Bearer%20eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkwMDA3MzMyLCJpYXQiOjE2ODk5NDY2MjMsImp0aSI6IjBlNWYzNjZlODU5ODQ2YWM4YjU1ZjdmMDgwYmEwZjc0IiwidXNlcl9pZCI6MX0.LZQkkvKnN5OmfdH_l7s581CvljZaXQpGxSnpBA9p8p4' \
  -H 'Origin: http://localhost:8080' \
  -H 'Referer: http://localhost:8080/report_research/not_initial' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
  -H 'sec-ch-ua: "Not.A/Brand";v="8", "Chromium";v="114", "Google Chrome";v="114"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "macOS"' \
  --data-raw '{"contact":"1","final_university":1,"final_program":"123"}' \
  --compressed