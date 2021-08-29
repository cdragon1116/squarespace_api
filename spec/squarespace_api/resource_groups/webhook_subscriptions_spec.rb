require 'spec_helper'

describe SquarespaceApi::ResourceGroups::WebhookSubscriptions do
  let(:connection) { SquarespaceApi::Connection.new(SquarespaceApi::Config.new).initialize_app_session }
  let(:api) { described_class.new(connection: connection) }

  describe "#send_test_notification" do
    before do
      stub_request(:post, "https://api.squarespace.com/1.0/webhook_subscriptions/1/actions/sendTestNotification")
        .with(body: { topic: 'extension.uninstall' }.to_json)
        .and_return(status: 200)
    end

    it "should send correct request" do
      expect(api.send_test_notification(1, { topic: 'extension.uninstall' })).to eq(true)
    end
  end

  describe "#rotate_secret" do
    before do
      stub_request(:post, "https://api.squarespace.com/1.0/webhook_subscriptions/1/actions/rotateSecret")
        .and_return(status: 200, body: { 'secret' => 'test_secret' }.to_json)
    end

    it "should send correct request" do
      expect(api.rotate_secret(1)).to eq('secret' => 'test_secret')
    end
  end
end
