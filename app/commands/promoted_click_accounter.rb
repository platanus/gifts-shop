class PromotedClickAccounter < PowerTypes::Command.new(:product_action, :organization)
  include Ledgerizer::Execution::Dsl

  def perform
    amount = Money.from_amount(ProductAction::PROMOTED_CLICK_COST)
    store = @product_action.store
    execute_promoted_click_entry(
      tenant: @organization,
      document: @product_action,
      date: @product_action.created_at
    ) do
      credit(account: :clicks_service, accountable: @organization, amount: amount)
      debit(account: :available_store_funds, accountable: store, amount: amount)
    end
    store.update_has_enough_balance
  end
end
