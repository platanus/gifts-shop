describe DepositAccounterJob do
  let(:deposit) { create :deposit }
  let(:perform) { described_class.perform_now(deposit) }

  before { allow(DepositAccounter).to receive(:for) }

  it 'calls DepositAccounter with that deposit' do
    perform

    expect(DepositAccounter).to(
      have_received(:for).with(deposit: deposit)
    )
  end
end
