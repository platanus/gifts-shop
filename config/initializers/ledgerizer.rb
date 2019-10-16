# Example:
#
# Ledgerizer.setup do |conf|
#   conf.tenant(:portfolio) do
#     conf.asset :bank
#     conf.liability :funds_to_invest
#     conf.liability :to_invest_in_fund
#
#     conf.entry :user_deposit, document: :user_deposit do
#       conf.debit account: :bank, accountable: :bank
#       conf.credit account: :funds_to_invest, accountable: :user
#     end
#
#     conf.entry :user_deposit_distribution, document: :user_deposit do
#       conf.debit account: :funds_to_invest, accountable: :user
#       conf.credit account: :to_invest_in_fund, accountable: :user
#     end
#   end
# end

Ledgerizer.setup do |conf|
  conf.tenant(:organization, currency: :clp) do
    conf.asset :bank_account
    conf.liability :available_store_funds
    conf.income :clicks_service

    conf.entry :promoted_click, document: :product_action do
      conf.credit account: :clicks_service, accountable: :organization
      conf.debit account: :available_store_funds, accountable: :store
    end

    conf.entry :store_deposit, document: :deposit do
      conf.credit account: :available_store_funds, accountable: :store
      conf.debit account: :bank_account, accountable: :organization
    end
  end
end
