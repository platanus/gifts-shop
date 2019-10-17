require 'rails_helper'

describe DepositAccounter do
  let(:deposit) { build(:deposit) }

  def perform
    described_class.new(deposit: deposit).perform
  end

  it "rearange balances" do
    perform

    available_store_funds = deposit.store.accounts.first
    bank_account = deposit.organization.accounts.where(name: :bank_account).first
    expect(available_store_funds.ledger_balance.fractional).to eq(deposit.amount)
    expect(bank_account.ledger_balance.fractional).to eq(deposit.amount)
  end

  it "creates store_deposit entry in ledgerizer" do
    perform

    expect(deposit.organization).to have_ledger_entry(
      entry_code: :store_deposit,
      entry_date: deposit.created_at,
      document: deposit
    )
  end

  # rubocop:disable RSpec/ExampleLength
  it "adds lines to ledgerizer" do
    perform

    last_entry = Ledgerizer::Entry.last
    expect(last_entry).to have_ledger_line(
      account_name: :bank_account,
      accountable: deposit.organization,
      amount: Money.from_amount(deposit.amount)
    )
    expect(last_entry).to have_ledger_line(
      account_name: :available_store_funds,
      accountable: deposit.store,
      amount: Money.from_amount(deposit.amount)
    )
  end
  # rubocop:enable RSpec/ExampleLength

  context "with store with has_enough_balance false" do
    let(:store) { build(:store, has_enough_balance: false) }
    let(:deposit) { build(:deposit, store: store) }

    it "updates store has_enough_balance to true" do
      perform

      expect(deposit.store.has_enough_balance).to be(true)
    end
  end
end
