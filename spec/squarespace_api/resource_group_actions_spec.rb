require 'spec_helper'
require 'squarespace_api/resource_group'

class DummyResrouce < SquarespaceApi::ResourceGroup
  allowed_actions :all, :find, :find_by_ids, :create, :delete, :update

  def initialize(connection)
    super
    @resource_config = {
      'resources_path' => 'commerce/dummy',
    }
  end

  def parse_collection(response)
    response.body['dummy']
  end
end

describe SquarespaceApi::ResourceGroupActions do
  let(:connection) { SquarespaceApi::Connection.new(SquarespaceApi::Config.new).initialize_app_session }
  let(:resource) { DummyResrouce.new(connection: connection) }

  describe '#all' do
    before do
      stub_request(:get, "https://api.squarespace.com/1.0/commerce/dummy?status=pending")
        .to_return(status: 200, body: { 'dummy' => [] }.to_json)
    end

    it { expect(resource.all(status: 'pending')).to eq([]) }
    it { expect(resource.where(status: 'pending')).to eq([]) }
  end

  describe '#find' do
    before do
      stub_request(:get, "https://api.squarespace.com/1.0/commerce/dummy/123")
        .to_return(status: 200, body: { id: 123 }.to_json)
    end

    it { expect(resource.find(123)).to eq("id" => 123) }
  end

  describe '#find_by_ids' do
    before do
      stub_request(:get, "https://api.squarespace.com/1.0/commerce/dummy/1,2,3")
        .to_return(status: 200, body: { 'dummy' => [] }.to_json)
    end

    it { expect(resource.find_by_ids([1, 2, 3])).to eq([]) }
  end

  describe '#create' do
    before do
      stub_request(:post, "https://api.squarespace.com/1.0/commerce/dummy")
        .to_return(status: 200)
    end

    it { expect(resource.create(some_data: 'data')).to eq(true) }
  end

  describe '#update' do
    before do
      stub_request(:post, "https://api.squarespace.com/1.0/commerce/dummy/123")
        .to_return(status: 200, body: { update_data: 'test data' }.to_json)
    end

    it { expect(resource.update(123, update_data: 1)).to eq('update_data' => 'test data') }
  end

  describe '#delete' do
    before do
      stub_request(:delete, "https://api.squarespace.com/1.0/commerce/dummy/123")
        .to_return(status: 200)
    end

    it { expect(resource.delete(123)).to eq(true) }
  end
end
