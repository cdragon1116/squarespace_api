require 'spec_helper'

describe SquarespaceApi::Client do
  let(:access_token) { "test_token" }
  let(:config) { SquarespaceApi::Config.new(access_token: access_token, client_id: 'your_client_id') }
  let(:client) { described_class.new(config) }


  describe "resource_groups methods" do
    it '#orders' do
      expect(client.orders).to be_a SquarespaceApi::ResourceGroups::Orders
    end

    it '#order_fulfillments' do
      expect(client.order_fulfillments).to be_a SquarespaceApi::ResourceGroups::OrderFulfillments
    end

    it '#products' do
      expect(client.products).to be_a SquarespaceApi::ResourceGroups::Products
    end

    it '#product_variants' do
      expect(client.product_variants).to be_a SquarespaceApi::ResourceGroups::ProductVariants
    end

    it '#product_images' do
      expect(client.product_images).to be_a SquarespaceApi::ResourceGroups::ProductImages
    end

    it '#product_variant_images' do
      expect(client.product_variant_images).to be_a SquarespaceApi::ResourceGroups::ProductVariantImages
    end

    it '#inventory' do
      expect(client.inventory).to be_a SquarespaceApi::ResourceGroups::Inventory
    end

    it '#inventory_adjustments' do
      expect(client.inventory_adjustments).to be_a SquarespaceApi::ResourceGroups::InventoryAdjustments
    end

    it '#profiles' do
      expect(client.profiles).to be_a SquarespaceApi::ResourceGroups::Profiles
    end

    it '#store_pages' do
      expect(client.store_pages).to be_a SquarespaceApi::ResourceGroups::StorePages
    end

    it '#transactions' do
      expect(client.transactions).to be_a SquarespaceApi::ResourceGroups::Transactions
    end

    it '#webhook_subscriptions' do
      expect(client.webhook_subscriptions).to be_a SquarespaceApi::ResourceGroups::WebhookSubscriptions
    end

    it '#tokens' do
      expect(client.tokens).to be_a SquarespaceApi::ResourceGroups::Tokens
    end
  end

  describe "#resources methods" do
    it '#website' do
      expect_any_instance_of(SquarespaceApi::Resources::Website).to receive(:get)
      client.website
    end
  end

  describe '#build_oauth_authorize_url' do
    it 'should construct correct url' do
      expect(client.build_oauth_authorize_url(
        redirect_url: 'https://api.test.com/squarespace',
        scope: 'website.orders,website.orders.read',
        state: '1234',
        access_type: "offline"
      )).to eq('https://login.squarespace.com/api/1/login/oauth/provider/authorize?client_id=your_client_id&redirect_url=https://api.test.com/squarespace&scope=website.orders,website.orders.read&state=1234&access_type=offline')
    end
  end
end
