require 'spec_helper'

describe SquarespaceApi::ResourceGroups::Orders do
  let(:access_token) { "test_token" }
  let(:config) { SquarespaceApi::Config.new(access_token: access_token) }
  let(:connection) { SquarespaceApi::Connection.new(config).initialize_app_session }
  let(:orders_api) { described_class.new(connection: connection) }

  describe "fulfil" do
    before { stub_request(:post, "https://api.squarespace.com/1.0/commerce/orders/123/fulfillments") }

    it "should send correct request" do
      orders_api.fulfil('123', { 'shouldSendNotification' => false })
      expect(a_request(:post, "https://api.squarespace.com/1.0/commerce/orders/123/fulfillments")
        .with(body: { shouldSendNotification: false }.to_json)).to have_been_made
    end
  end
end
