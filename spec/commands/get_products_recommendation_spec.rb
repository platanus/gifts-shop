require 'rails_helper'

describe GetProductsRecommendation do
  let(:recommender_url) { "http://rec.com" }
  let(:receiver) { create(:receiver) }
  let(:number_of_products) { 3 }
  let(:promoted) { 1 }
  let(:request_url) do
    "#{recommender_url}/recommend/#{receiver.id}/#{number_of_products}?min_promoted=#{promoted}"
  end
  let(:products) { [] }

  def perform
    described_class.for(
      receiver: receiver,
      number_of_products: number_of_products,
      promoted: promoted
    )
  end

  before do
    stub_const('GetProductsRecommendation::URL', recommender_url)
    stub_request(:get, request_url).to_return(body: { product_ids: products.pluck(:id) }.to_json)
  end

  context 'when no more products to recommend' do
    it 'returns empty array' do
      expect(perform).to eq([])
    end
  end

  context 'when there are products to recommend' do
    let(:products) { create_list(:product, 3) }

    it 'returns ordered product array' do
      expect(perform).to eq(products)
    end
  end

  context 'when the recommender is down' do
    before do
      stub_request(:get, request_url).to_raise(Errno::ECONNREFUSED)
      create_list(:product, 5)
    end

    it 'returns some products' do
      expect(perform).to eq(Product.first(3))
    end
  end
end
