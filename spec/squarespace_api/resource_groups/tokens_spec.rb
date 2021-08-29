require 'spec_helper'

describe SquarespaceApi::ResourceGroups::Tokens do
  let(:connection) { SquarespaceApi::Connection.new(SquarespaceApi::Config.new).initialize_app_session }
  let(:api) { described_class.new(connection: connection) }

  let(:token_response) do
    {
      "token" => "T1|Rr0Wc95uu3cSeBh06yB...",
      "token_type" => "bearer",
      "access_token" => "T1|Rr0Wc95uu3cSeBh06yB...",
      "access_token_expires_at" => "1553532363.542",
      "refresh_token" => "1|KYUYh35zcwzx4Zt/oty3...",
      "refresh_token_expires_at" => "1554135363.542"
    }
  end

  describe "#create" do
    before do
      stub_request(:post, "https://login.squarespace.com/api/1/login/oauth/provider/tokens")
        .with(headers: { 'Authorization'=>'Basic Og==' })
        .and_return(status: 200, body: token_response.to_json)
    end

    it "should get expected response" do
      expect(api.create(
        refresh_token: 'some_refresh_token',
        grant_type: "refresh_token"
      )).to eq(token_response)
    end
  end
end
