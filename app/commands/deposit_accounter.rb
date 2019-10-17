class DepositAccounter < PowerTypes::Command.new(:deposit)
  include Ledgerizer::Execution::Dsl

  def perform
    money_amount = Money.from_amount(@deposit.amount)
    execute_store_deposit_entry(
      tenant: @deposit.organization,
      document: @deposit,
      date: @deposit.deposit_time
    ) do
      credit(account: :available_store_funds, accountable: @deposit.store, amount: money_amount)
      debit(account: :bank_account, accountable: @deposit.organization, amount: money_amount)
    end
    @deposit.store.update_has_enough_balance
  end
end
