require 'rails_helper'

RSpec.describe WeatherService do
  let(:query) { 'City, Country' }
  let(:weather_service) { described_class.new(query: query) }

  describe '.current_weather' do
    subject { described_class.current_weather(query: query) }

    context 'when weather is successfully retrieved' do
      let(:location) {
        instance_double(
          'Geocoder::Result::Location',
          country: "Country",
          postal_code: "12345",
          city: "City",
          coordinates: [12, 34],
        )
      }
      let(:weather) { { 'temperature' => 25, 'conditions' => 'Sunny' } }

      before do
        allow(Geocoder).to receive_message_chain(:search, :first).and_return(location)
        allow(Rails.cache).to receive(:fetch).and_yield
        allow_any_instance_of(WeatherServiceClient).to receive(:current_weather).and_return(weather)
      end

      it 'returns an array with cached flag, location, and weather' do
        expect(subject).to eq([false, location, weather])
      end

      it 'caches the weather data' do
        expect(Rails.cache).to receive(:fetch).with(any_args).and_yield
        subject
      end
    end

    context 'when weather is retrieved from the cache' do
      let(:location) {
        instance_double(
          'Geocoder::Result::Location',
          country: "Country",
          postal_code: "12345",
          city: "City",
          coordinates: [12, 34],
        )
      }
      let(:weather) { { 'temperature' => 25, 'conditions' => 'Sunny' } }

      before do
        allow(Geocoder).to receive_message_chain(:search, :first).and_return(location)
        allow(Rails.cache).to receive(:fetch).and_return(weather)
      end

      it 'returns an array with cached flag, location, and weather' do
        expect(subject).to eq([true, location, weather])
      end

      it 'does not call the external weather service' do
        expect_any_instance_of(WeatherServiceClient).not_to receive(:current_weather)
        subject
      end
    end

    context 'when an error occurs while retrieving weather' do
      before do
        allow(Geocoder).to receive_message_chain(:search, :first).and_raise(StandardError)
      end

      it 'raises ForecastUnavailableError' do
        expect { subject }.to raise_error(WeatherService::ForecastUnavailableError)
      end

      it 'logs the error' do
        expect(Rails.logger).to receive(:error).with(any_args)
        subject rescue nil
      end
    end
  end
end
