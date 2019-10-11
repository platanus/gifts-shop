class DepositAccounter < PowerTypes::Command.new(:store, :organization, :amount)
  include Ledgerizer::Execution::Dsl

  def perform
    deposit = Deposit.create(
      store: @store,
      organization: @organization,
      amount: @amount,
      amount_currency: Money.default_currency.iso_code
    )
    money_amount = Money.from_amount(@amount)
    execute_store_deposit_entry(
      tenant: @organization,
      document: deposit,
      date: deposit.created_at
    ) do
      credit(account: :available_store_funds, accountable: @store, amount: money_amount)
      debit(account: :bank_account, accountable: @organization, amount: money_amount)
    end
  end
end
