# Description
#   a hubot weather reporter
#
# Configuration:
#   HUBOT_WEATHER_WUNDERGROUND_KEY
#
# Commands:
#   hubot weather of PLACE <show the weather of a place>
#   hubot what is PLACE exactly called? <find the exact name of a place>
#
# Author:
#   K.K. POON <noopkk@gmail.com>

WUNDERGROUND_KEY = process.env.HUBOT_WEATHER_WUNDERGROUND_KEY
WUNDERGROUND_UNITS = process.env.HUBOT_WEATHER_WUNDERGROUND_UNITS
WUNDERGROUND_URL = "http://api.wunderground.com/api/#{WUNDERGROUND_KEY}"

module.exports = (robot) ->
  robot.respond /weather (.*)/i, (msg) ->
    place = msg.match[1]

    msg.http("#{WUNDERGROUND_URL}/conditions/q/#{place}.json")
      .get() (err, res, body) ->
        if err
          msg.send err
          robot.emit 'error', err
          return

        try
          data = JSON.parse(body)
          obs = data.current_observation
          switch WUNDERGROUND_UNITS
            when "c"
              msg.send "The current weather condition of " +
              "#{obs.display_location.full} is #{obs.weather}:\n" +
              "#{obs.observation_time}, " +
              "Temperature is #{obs.temp_c}°C " +
              "(feels like #{obs.feelslike_c}°#C), " +
              "Humidity #{obs.relative_humidity}, " +
              "Pressure #{obs.pressure_mb}hPa, " +
              "Wind #{obs.wind_string}, " +
              "UV #{obs.UV}\n" +
              "More information: #{obs.ob_url}"
            when "f"
              msg.send "The current weather condition of " +
              "#{obs.display_location.full} is #{obs.weather}:\n" +
              "#{obs.observation_time}, " +
              "Temperature is #{obs.temp_f}°F " +
              "(feels like #{obs.feelslike_f}°#f), " +
              "Humidity #{obs.relative_humidity}, " +
              "Pressure #{obs.pressure_mb}hPa, " +
              "Wind #{obs.wind_string}, " +
              "UV #{obs.UV}\n" +
              "More information: #{obs.ob_url}"
            else msg.send "Please define WUNDERGROUND_UNITS"

        catch err
          msg.send err
          robot.emit 'error', err


  robot.respond /what is (.*) (exactly|exact) (called|named|call|name)[\?]?/i, (msg) ->
    place = msg.match[1]

    msg.http("http://autocomplete.wunderground.com/aq?query=#{place}")
      .get() (err, res, body) ->
        if err
          msg.send err
          robot.emit 'error', err
          return

        try
          data = JSON.parse(body)
          results = data.RESULTS
          msg.send "Here are the possibilities:\n" +
            ("- " + r.name for r in results).join "\n"

        catch err
          msg.send err
          robot.emit 'error', err
