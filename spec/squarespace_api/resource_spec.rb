require 'spec_helper'

class Dummy < SquarespaceApi::Resource
  PATH = 'commerce/dummy'
end

describe SquarespaceApi::Resource do
  let(:connection) { SquarespaceApi::Connection.new(SquarespaceApi::Config.new).initialize_app_session }
  let(:resource) { Dummy.new(connection: connection) }

  describe '#get' do
    before do
      stub_request(:get, "https://api.squarespace.com/1.0/commerce/dummy")
        .to_return(status: 200, body: { 'name': 'dummy'  }.to_json)
    end

    it { expect(resource.get).to eq('name' => 'dummy') }
  end
end
