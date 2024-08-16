from flask import Flask, request
import requests

app = Flask(__name__)

# Function to fetch weather information
def get_weather(city, api_key):
    url = f"http://api.openweathermap.org/data/2.5/weather?q={city}&appid={api_key}&units=metric"
    response = requests.get(url)
    data = response.json()
    if 'main' in data:
        temperature = data['main']['temp']
        return temperature
    else:
        return None

@app.route('/')
def greet():
    client_ip = request.remote_addr
    container_name = "Silverfort's Docker Container"
    tel_aviv_weather = get_weather('Tel Aviv', 'b4fc0dce4da2716999fdca8c2fd0cb9b')
    if tel_aviv_weather is not None:
        return f"Hello {client_ip} and welcome to {container_name}. The weather in Tel Aviv is {tel_aviv_weather} °C"
    else:
        return f"Hello {client_ip} and welcome to {container_name}. Weather information is currently unavailable for Tel Aviv."

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, ssl_context=('cert.pem', 'key.pem'))
