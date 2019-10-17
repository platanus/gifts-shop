class DepositObserver < PowerTypes::Observer
  after_save :execute_deposit_accounter

  def execute_deposit_accounter
    DepositAccounterJob.perform_later(object)
  end
end
