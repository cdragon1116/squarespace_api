require 'spec_helper'

describe SquarespaceApi::Config do
  let(:config) do
    described_class.new(
      client_id: 'test_client_id',
      client_secret: 'test_client_secret',
      access_token: 'test_access_token'
    )
  end

  it 'has an client_id' do
    expect(config.client_id).to eq('test_client_id')
  end

  it 'has an client_secret' do
    expect(config.client_secret).to eq('test_client_secret')
  end

  it 'has an access_token' do
    expect(config.access_token).to eq('test_access_token')
  end
end
