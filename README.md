# hubot-weather-underground

a hubot weather reporter

See [`src/weather.coffee`](src/weather.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-weather-underground --save`

Then add **hubot-weather-underground** to your `external-scripts.json`:

```json
["hubot-weather-underground"]
```

## Set the environment variables

`HUBOT_WEATHER_WUNDERGROUND_KEY=YOUR_WUNDERGROUND_KEY`

`HUBOT_WEATHER_WUNDERGROUND_UNITS=f` - for Fahrenheit

`HUBOT_WEATHER_WUNDERGROUND_UNITS=c` - for Celcius

## Sample Interaction

```
user1>> hubot weather of Hong Kong
hubot>> The current weather condition of Hong Kong is Light Rain Showers:
At Fri, 29 Jan 2016 09:13:02 +0800, Temperature is 16.4°C (feels like 16.4°C), Humidity: 94%, Pressure: 1018hPa, Wind: Calm, UV: 1.0
user1>> hubot what is Sha Tin exactly called?
hubot>> Here are the possibilities:
Sha Tin, China
Sha Tin Racecourse, China
Sha Tin Sports Ground, China
Sha Tin Tau, Hong Kong
Sha Tin Wai, Hong Kong
Sha Tin, Hong Kong
```
