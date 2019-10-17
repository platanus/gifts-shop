class DepositAccounterJob < ApplicationJob
  queue_as :default

  def perform(deposit)
    DepositAccounter.for(deposit: deposit)
  end
end
