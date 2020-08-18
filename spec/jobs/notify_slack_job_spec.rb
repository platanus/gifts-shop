describe NotifySlackJob do
  let(:product) { create :product }
  let(:perform) { described_class.perform_now(product) }

  before { allow(NotifyProduct).to receive(:for) }

  it 'calls NotifyProduct with that product' do
    perform

    expect(NotifyProduct).to(
      have_received(:for).with(product: product)
    )
  end
end
