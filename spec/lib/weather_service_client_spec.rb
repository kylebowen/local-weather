require 'rails_helper'

RSpec.describe WeatherServiceClient, type: :service do
  let(:weather_service_client) {
    # Workaround for the stdlib Singleton module that prevents calling `.new` on a class.
    # We need to do this here so that the singleton instance doesn't leak between specs.
    # Code should always access using `.instance`.
    described_class.send(:new)
  }
  let(:open_weather) { instance_double('OpenWeather::Client', current_weather: { fake: :weather }) }
  let(:api_key) { 'irrelephant' }
  let(:nyc_city_hall) {
    {
      lat: 40.7128,
      lon: -74.0060,
      lang: :en,
      units: :imperial,
    }
  }

  before do
    allow(AppSettings).to receive(:open_weather_api_key).and_return(api_key)
    allow(OpenWeather::Client).to receive(:new).with(api_key: api_key).and_return(open_weather)
  end

  describe '#current_weather' do
    subject { weather_service_client.current_weather(**nyc_city_hall) }

    it 'calls current_weather on the OpenWeather client' do
      expect(open_weather).to receive(:current_weather).with(**nyc_city_hall)
      subject
    end

    it 'calls open_weather only once and caches the instance' do
      expect(OpenWeather::Client).to receive(:new).once.and_return(open_weather)
      2.times { weather_service_client.current_weather(**nyc_city_hall) }
    end
  end

  describe '#open_weather' do
    subject { weather_service_client.open_weather }

    it 'returns the OpenWeather client instance' do
      expect(subject).to eq(open_weather)
    end

    it 'caches the OpenWeather client instance' do
      expect(OpenWeather::Client).to receive(:new).once.and_return(open_weather)
      2.times { weather_service_client.open_weather }
    end
  end
end

