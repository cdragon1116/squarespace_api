require 'spec_helper'

describe SquarespaceApi::Connection do
  let(:config) { SquarespaceApi::Config.new( access_token: 'test_access_token') }
  let(:connection) { described_class.new(config) }

  describe "#request" do
    before do
      stub_request(:get, "https://api.squarespace.com")
        .to_return(status: status_code, body: body.to_json, headers: { "Content-Type" => "application/json" })
    end

    let(:status_code) { 200 }
    let(:body) { { "result" => {} } }
    it "should send http request" do
      connection.get('https://api.squarespace.com')
      expect(a_request(:get, "https://api.squarespace.com")).to have_been_made
    end

    context "when request fails" do
      let(:status_code) { 401 }
      let(:body) { { message: "Unauthorized" } }
      it "should raise error" do
        expect {
          connection.get('https://api.squarespace.com')
        }.to raise_error(SquarespaceApi::Errors::Unauthorized, "Unauthorized")
      end
    end
  end

  describe "#with_app_session" do
    before do
      stub_request(:get, "https://api.squarespace.com/1.0/commerce/orders")
        .to_return(status: 200, body: {}.to_json, headers: { "Content-Type" => "application/json" })
    end

    it "should send http request" do
      connection.with_app_session { connection.get('commerce/orders') }

      expect(a_request(:get, "https://api.squarespace.com/1.0/commerce/orders")
        .with(headers: {Authorization: "Bearer test_access_token"})).to have_been_made
    end
  end

  describe "#with_oauth_session" do
    before do
      stub_request(:get, "https://login.squarespace.com/api/1/login/oauth/provider/token")
        .to_return(status: 200, body: {}.to_json, headers: { "Content-Type" => "application/json" })
    end

    it "should send http request" do
      connection.with_oauth_session { connection.get('token') }

      expect(a_request(:get, "https://login.squarespace.com/api/1/login/oauth/provider/token")
        .with(headers: {Authorization: "Basic Og=="})).to have_been_made
    end
  end
end
