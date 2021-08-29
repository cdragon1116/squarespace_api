require 'spec_helper'

describe SquarespaceApi::ResourceGroups::ProductImages do
  let(:connection) { SquarespaceApi::Connection.new(SquarespaceApi::Config.new).initialize_app_session }
  let(:api) { described_class.new(connection: connection) }

  describe "#status" do
    before { stub_request(:get, "https://api.squarespace.com/1.0/commerce/products/1/images/1/status") }

    it "should send correct request" do
      api.status(1, { product_id: '1' })
      expect(a_request(:get, "https://api.squarespace.com/1.0/commerce/products/1/images/1/status")).to have_been_made
    end
  end

  describe "#reorder" do
    before { stub_request(:post, "https://api.squarespace.com/1.0/commerce/products/1/images/1/order") }

    it "should send correct request" do
      api.order(1, { product_id: '1', afterImageId: '2' })
      expect(a_request(:post, "https://api.squarespace.com/1.0/commerce/products/1/images/1/order")
        .with(body: { 'afterImageId' => '2' }.to_json)).to have_been_made
    end
  end
end
