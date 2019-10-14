require 'rails_helper'

describe PromotedClickAccounter do
  let(:store) { build(:store) }
  let(:organization) { build(:organization) }
  let(:amount) { ENV.fetch('CPC').to_i }
  let(:product_action) do
    product = build(:product, store: store)
    build(:product_action, product: product, created_at: Date.current)
  end

  def perform
    described_class.new(
      store: store,
      organization: organization,
      product_action: product_action
    ).perform
  end

  it "rearange balances" do
    perform

    available_store_funds = store.accounts.first
    clicks_service = organization.accounts.where(name: :clicks_service).first
    expect(available_store_funds.ledger_balance.fractional).to eq(amount * -1)
    expect(clicks_service.ledger_balance.fractional).to eq(amount)
  end

  it "creates promoted_click entry in ledgerizer" do
    perform

    product_action = ProductAction.last
    expect(organization).to have_ledger_entry(
      entry_code: :promoted_click,
      entry_date: product_action.created_at,
      document: product_action
    )
  end

  it "adds lines to ledgerizer" do
    perform

    last_entry = Ledgerizer::Entry.last
    expect(last_entry).to have_ledger_line(
      account_name: :clicks_service, accountable: organization, amount: Money.from_amount(amount)
    )
    expect(last_entry).to have_ledger_line(
      account_name: :available_store_funds,
      accountable: store,
      amount: Money.from_amount(amount * -1)
    )
  end
end
