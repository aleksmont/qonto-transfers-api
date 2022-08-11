require 'rails_helper'

RSpec.describe "Transaction Service" do
  before(:all) do
    @service = TransactionService.new
    @bank_account_service = BankAccountService.new

    sample1_file = File.read('./spec/fixtures/sample1.json')
    @sample1_data = JSON.parse(sample1_file)

    sample2_file = File.read('./spec/fixtures/sample2.json')
    @sample2_data = JSON.parse(sample2_file)

    sample_balance_file = File.read('./spec/fixtures/sample_balance.json')
    @sample_balance_data = JSON.parse(sample_balance_file)

    bank1_result = @bank_account_service.find_by_json_sample(@sample1_data)
    @bank1 = bank1_result[:bank_account]

    bank2_result = @bank_account_service.find_by_json_sample(@sample2_data)
    @bank2 = bank2_result[:bank_account]

    @transaction_count = Transaction.count
  end

  describe ".perform" do
    context "given a list of transfers" do
      it "returns ok" do
        result1 = @service.perform(@bank1, @sample1_data["credit_transfers"])
        expect(result1[:error]).to eq(false)
        expect(Transaction.count).to eq(5)

        result2 = @service.perform(@bank2, @sample2_data["credit_transfers"])
        expect(result2[:error]).to eq(false)
        expect(Transaction.count).to eq(9)
      end

      it "returns error" do
        result1 = @service.perform(@bank1, [])
        expect(result1[:error]).to eq(true)
        expect(Transaction.count).to eq(@transaction_count)
      end

      it "returns error because of not enough balance" do
        result_balance = @service.perform(@bank2, @sample_balance_data["credit_transfers"])
        expect(result_balance[:error]).to eq(true)
        expect(Transaction.count).to eq(@transaction_count)
      end
    end
  end
end
