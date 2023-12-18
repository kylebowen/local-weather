# Local Weather App

Welcome to the Local Weather App! This Ruby on Rails project allows users to input an address, city, or zip code and view the current weather forecast.

<img width="872" alt="Screenshot 2023-12-18 at 1 52 58 AM" src="https://github.com/kylebowen/local-weather/assets/15739331/f56cfb52-e673-42a3-a1db-907bd878479e">

---

## Getting Started

### Prerequisites

Make sure you have the following installed:

- Ruby (version 3.2.2)
- Rails (version 7.1.2)
- PostgreSQL (version 9.3+)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/kylebowen/local-weather.git
   ```

2. Navigate to the project directory:

   ```bash
   cd local-weather
   ```

5. Install dependencies:

   ```bash
   bundle install
   ```

6. [OPTIONAL] Create the database and run migrations:

   ```bash
   rails db:create
   rails db:migrate
   ```

7. Set up your environment variables by creating a `.env` file:

   ```bash
   touch .env
   ```

   Add the following content to the `.env` file:

   ```dotenv
   GEOCODER_API_KEY=<your_geocoder_api_key>
   OPEN_WEATHER_API_KEY=<your_open_weather_api_key>
   ```

   Replace `<your_geocoder_api_key>` and `<your_open_weather_api_key>` with your actual API keys.

8. Run the specs:

   ```bash
   bin/rspec
   ```

6. [OPTIONAL] Enable local caching:

   ```bash
   rails dev:cache
   ```
   Disable local caching by running the same command again. The server will restart itself.

7. Start the Rails server:

   ```bash
   rails server
   ```

   The application will be available at [http://localhost:3000](http://localhost:3000).

## Features

- **Weather Lookup:** Enter an address, city, or zip code to get the current weather forecast.
- **Geolocation:** Utilizes the [`geocoder`](https://github.com/alexreisner/geocoder) gem for geolocation services.
- **Weather API:** Uses the [`open-weather-ruby-client`](https://github.com/dblock/open-weather-ruby-client) gem to fetch weather information.
- **Environment Variables:** Requires `GEOCODER_API_KEY` and `OPEN_WEATHER_API_KEY` as environment variables.
- **Database:** Configured with a PostgreSQL database for upcoming features (not currently used).
- **Caching:** Utilizes Rails cache to store weather API responses for 30 minutes.
- **Styling:** Uses the [`tailwindcss-rails`](https://github.com/rails/tailwindcss-rails) gem for styling the front end.
- **Testing:** Includes specs using the `rspec-rails` gem.

## Usage

1. Open your browser and go to [http://localhost:3000](http://localhost:3000).
2. Enter an address, city, or zip code in the provided input field.
3. Click the `search-icon` button to see the current weather forecast.

## Contributing

If you'd like to contribute to the project, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).

---

Enjoy using the Local Weather App! If you encounter any issues or have suggestions, feel free to open an issue on the GitHub repository. Happy coding!
