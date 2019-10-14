require 'rails_helper'

describe DepositAccounter do
  let(:store) { build(:store) }
  let(:organization) { build(:organization) }
  let(:amount) { 5000 }

  def perform
    described_class.new(
      store: store,
      organization: organization,
      amount: amount
    ).perform
  end

  it "rearange balances" do
    perform

    available_store_funds = store.accounts.first
    bank_account = organization.accounts.where(name: :bank_account).first
    expect(available_store_funds.ledger_balance.fractional).to eq(amount)
    expect(bank_account.ledger_balance.fractional).to eq(amount)
  end

  it "creates Deposit instance" do
    expect { perform }.to change { Deposit.count }.from(0).to(1)

    store_deposit = Deposit.last
    expect(store_deposit).to have_attributes(
      store: store,
      amount: amount,
      amount_currency: Money.default_currency.iso_code,
      organization: organization
    )
  end

  it "creates store_deposit entry in ledgerizer" do
    perform

    store_deposit = Deposit.last
    expect(organization).to have_ledger_entry(
      entry_code: :store_deposit,
      entry_date: store_deposit.created_at,
      document: store_deposit
    )
  end

  it "adds lines to ledgerizer" do
    perform

    last_entry = Ledgerizer::Entry.last
    expect(last_entry).to have_ledger_line(
      account_name: :bank_account, accountable: organization, amount: Money.from_amount(amount)
    )
    expect(last_entry).to have_ledger_line(
      account_name: :available_store_funds, accountable: store, amount: Money.from_amount(amount)
    )
  end
end
