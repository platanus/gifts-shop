class BankPolicy < ApplicationPolicy
  def update?
    false
  end

  def destroy?
    false
  end

  def edit?
    false
  end
end
