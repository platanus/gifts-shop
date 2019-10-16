class PromotedClickAccounter < PowerTypes::Command.new(:product_action, :store, :organization)
  include Ledgerizer::Execution::Dsl

  def perform
    amount = Money.from_amount(ENV.fetch('CPC').to_i)
    execute_promoted_click_entry(
      tenant: @organization,
      document: @product_action,
      date: @product_action.created_at
    ) do
      credit(account: :clicks_service, accountable: @organization, amount: amount)
      debit(account: :available_store_funds, accountable: @store, amount: amount)
    end
  end
end
