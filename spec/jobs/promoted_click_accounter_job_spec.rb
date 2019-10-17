describe PromotedClickAccounterJob do
  let(:product_action) { create :product_action }
  let(:organization) { create :organization }
  let(:perform) { described_class.perform_now(product_action, organization) }

  before { allow(PromotedClickAccounter).to receive(:for) }

  it 'calls PromotedClickAccounter with that product_action and organization' do
    perform

    expect(PromotedClickAccounter).to(
      have_received(:for).with(
        product_action: product_action,
        organization: organization
      )
    )
  end
end
