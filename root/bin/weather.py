#!/usr/bin/python3

import requests
import json
import socket

hostname = socket.gethostname()

j = json.JSONDecoder()
r = requests.get(
    'http://api.openweathermap.org/data/2.5/weather?zip=45449,us&units=imperial&appid=8c7a3eda698041f3d194181a7b1da8c5')

weather = r.json()
display = ''
if hostname == 'geeko':
    display = display + weather['weather'][0]['main']
    if weather['weather'][0]['main'] != weather['weather'][1]['main']:
        display = display + ' or '
        display = display + weather['weather'][1]['main']
    display = display + ' '

display = display + str(weather['main']['temp'])
display = display + 'F'
print(display)
