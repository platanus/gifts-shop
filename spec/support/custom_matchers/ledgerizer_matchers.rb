module Ledgerizer
  module TestHelpers
    def self.tenant_definition(dsl_holder, tenant_class)
      dsl_holder&.definition&.find_tenant(tenant_class)
    end

    def self.tenant_account_definition(dsl_holder, tenant_class, account_name)
      tenant_definition(dsl_holder, tenant_class)&.find_account(account_name)
    end

    def self.tenant_entry_definition(dsl_holder, tenant_class, entry_code)
      tenant_definition(dsl_holder, tenant_class)&.find_entry(entry_code)
    end

    def self.tenant_entry_movement_definition(
      dsl_holder, tenant_class, entry_code, movement_type, account, accountable
    )
      tenant_entry_definition(dsl_holder, tenant_class, entry_code)&.find_movement(
        movement_type: movement_type,
        account_name: account,
        accountable: accountable
      )
    end
  end
end

RSpec::Matchers.define :have_ledger_tenant_definition do |model_name|
  match do |dsl_holder|
    Ledgerizer::TestHelpers.tenant_definition(dsl_holder, model_name)&.model_name == model_name
  end

  description do
    "include #{model_name} tenant"
  end

  failure_message do |dsl_holder|
    "#{dsl_holder} does not include #{model_name} tenant"
  end
end

RSpec::Matchers.define :have_ledger_tenant_currency do |model_name, expected_currency|
  match do |dsl_holder|
    Ledgerizer::TestHelpers.tenant_definition(dsl_holder, model_name)&.currency == expected_currency
  end

  description do
    "include #{expected_currency} in #{model_name} tenant"
  end

  failure_message do
    "#{expected_currency} is not the tenant's currency"
  end
end

RSpec::Matchers.define :have_ledger_account_definition do
  |tenanat_model_name:, account_name:, account_type:, contra: false|
  match do |dsl_holder|
    account = Ledgerizer::TestHelpers.tenant_account_definition(
      dsl_holder, tenanat_model_name, account_name
    )
    account && account.type == account_type &&
      account.name == account_name &&
      account.contra == contra
  end

  description do
    "include #{account_type} in #{tenanat_model_name} with name #{account_name}"
  end

  failure_message do
    "#{account_type} named #{account_name} with contra #{contra} is not in tenant"
  end
end

RSpec::Matchers.define :have_ledger_entry_definition do |tenant_model_name:, entry_code:, document:|
  match do |dsl_holder|
    entry = Ledgerizer::TestHelpers.tenant_entry_definition(
      dsl_holder, tenant_model_name, entry_code
    )
    entry && entry.document == document && entry.code == entry_code
  end

  description do
    "include #{entry_code} entry in #{tenant_model_name} tenant with #{document} document"
  end

  failure_message do
    "#{entry_code} entry is not in tenant"
  end
end

RSpec::Matchers.define :have_ledger_movement_definition do
  |tenant_class:, entry_code:, movement_type:, account:, accountable:|
  match do |dsl_holder|
    movement = Ledgerizer::TestHelpers.tenant_entry_movement_definition(
      dsl_holder,
      tenant_class,
      entry_code,
      movement_type,
      account,
      accountable
    )

    !!movement
  end

  description do
    "include #{expected} in #{entry_code} entry of #{tenant_class} tenant"
  end

  failure_message do
    "#{expected} entry is not in #{entry_code} entry of #{tenant_class} tenant"
  end
end

RSpec::Matchers.define :have_ledger_entry do |entry_code:, entry_date:, document:|
  match do |tenant|
    !!Ledgerizer::Entry.find_by(
      tenant: tenant,
      code: entry_code,
      document: document,
      entry_date: entry_date
    )
  end

  description do
    "include #{entry_code} entry with with date #{entry_date} and #{document.class} document"
  end

  failure_message do
    "#{entry_code} with given params is not a tenant's entry"
  end
end

RSpec::Matchers.define :have_ledger_line do
  |accountable:, amount:, account_name: nil, account: nil|
  acc = account_name || account
  fail "missing account_name" unless acc

  match do |entry|
    currency = amount.currency.to_s
    account = Ledgerizer::Account.find_by(
      tenant: entry.tenant,
      name: acc,
      accountable: accountable,
      currency: currency
    )

    !!entry.lines.find_by(
      amount_cents: amount.cents,
      amount_currency: currency,
      account: account
    )
  end

  description do
    "include line with #{acc} account and #{amount} amount"
  end

  failure_message do
    "line with given params is not in entry"
  end
end
