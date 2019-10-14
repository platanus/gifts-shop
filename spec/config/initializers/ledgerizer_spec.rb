require "rails_helper"

# rubocop:disable RSpec/NestedGroups
describe Ledgerizer do
  describe 'Platanus tenant' do
    let(:tenant) { :organization }

    context "with valid Active Record tenant" do
      it { expect(described_class).to have_ledger_tenant_definition(tenant) }
      it { expect(described_class).to have_ledger_tenant_currency(tenant, :clp) }
    end

    describe "accounts" do
      let(:expected) do
        {
          tenanat_model_name: tenant,
          account_name: account_name,
          account_type: account_type,
          contra: contra
        }
      end

      context "with bank account" do
        let(:account_name) { :bank_account }
        let(:account_type) { :asset }
        let(:contra) { false }

        it { expect(described_class).to have_ledger_account_definition(expected) }
      end

      context "with funds_to_invest account" do
        let(:account_name) { :available_store_funds }
        let(:account_type) { :liability }
        let(:contra) { false }

        it { expect(described_class).to have_ledger_account_definition(expected) }
      end

      context "with to_invest_in_fund account" do
        let(:account_name) { :clicks_service }
        let(:account_type) { :income }
        let(:contra) { false }

        it { expect(described_class).to have_ledger_account_definition(expected) }
      end
    end

    describe "entries" do
      let(:expected) do
        {
          tenant_model_name: tenant,
          entry_code: entry_code,
          document: document
        }
      end

      context "with promoted_click" do
        let(:entry_code) { :promoted_click }
        let(:document) { :product_action }

        it { expect(described_class).to have_ledger_entry_definition(expected) }

        describe "movements" do
          let(:expected) do
            {
              tenant_class: tenant,
              entry_code: entry_code,
              movement_type: movement_type,
              account: account_name,
              accountable: accountable
            }
          end

          context "with clicks_service movement" do
            let(:movement_type) { :credit }
            let(:account_name) { :clicks_service }
            let(:accountable) { :organization }

            it { expect(described_class).to have_ledger_movement_definition(expected) }
          end

          context "with available_store_funds movement" do
            let(:movement_type) { :debit }
            let(:account_name) { :available_store_funds }
            let(:accountable) { :store }

            it { expect(described_class).to have_ledger_movement_definition(expected) }
          end
        end
      end

      context "with store_deposit" do
        let(:entry_code) { :store_deposit }
        let(:document) { :deposit }

        it { expect(described_class).to have_ledger_entry_definition(expected) }

        describe "movements" do
          let(:expected) do
            {
              tenant_class: tenant,
              entry_code: entry_code,
              movement_type: movement_type,
              account: account_name,
              accountable: accountable
            }
          end

          context "with available_store_funds movement" do
            let(:movement_type) { :credit }
            let(:account_name) { :available_store_funds }
            let(:accountable) { :store }

            it { expect(described_class).to have_ledger_movement_definition(expected) }
          end

          context "with bank_account movement" do
            let(:movement_type) { :debit }
            let(:account_name) { :bank_account }
            let(:accountable) { :organization }

            it { expect(described_class).to have_ledger_movement_definition(expected) }
          end
        end
      end
    end
  end
end
# rubocop:enable RSpec/NestedGroups
