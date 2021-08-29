require 'spec_helper'

describe SquarespaceApi do
  it 'has a version number' do
    expect(SquarespaceApi::VERSION).to eq('0.0.4')
  end

  context 'configure' do
    SquarespaceApi.configure do |config|
      config.access_token = 'access_token'
      config.client_id = 'client_id'
      config.client_secret = 'client_secret'
    end

    it 'should configure' do
      expect(SquarespaceApi.config.access_token).to eq('access_token')
      expect(SquarespaceApi.config.client_id).to eq('client_id')
      expect(SquarespaceApi.config.client_secret).to eq('client_secret')
    end
  end
end
