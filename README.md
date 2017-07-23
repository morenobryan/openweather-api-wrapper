# README

A simple application to display weather information from OpenWeather API. Displays weather from a city or from a random coordinate.

### Things to improve

- Make a wrapper to improve the API interface for the views (removing the need for calls like @weather.main.humidity for something more fluid)
- Add a dropdown to select the country and therefore remove the need to enter the country code
- Cache the results
- Support unit switch directly from the interface
- Support searching for coordinates (the backend is ready, but needs frontend implementation)
- Handle better on the interface some information not being available (like visibility, or humidity)
- Show the city's current time on search
- Support forecast for 5 days
