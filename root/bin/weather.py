#!/usr/bin/python

import requests
import json

j = json.JSONDecoder()
r = requests.get('http://api.openweathermap.org/data/2.5/weather?zip=45066,us&units=imperial&appid=8c7a3eda698041f3d194181a7b1da8c5')

weather =  r.json()
print(weather['main']['temp'])
