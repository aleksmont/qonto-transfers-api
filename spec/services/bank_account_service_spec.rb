require 'rails_helper'

RSpec.describe "Bank Account Service" do
  before(:all) do
    @service = BankAccountService.new

    sample1_file = File.read('./spec/fixtures/sample1.json')
    @sample1_data = JSON.parse(sample1_file)

    sample2_file = File.read('./spec/fixtures/sample2.json')
    @sample2_data = JSON.parse(sample2_file)

    sample_bank_not_found_file = File.read('./spec/fixtures/sample_bank_not_found.json')
    @sample_bank_not_found_data = JSON.parse(sample_bank_not_found_file)
  end

  describe ".find_by_json_sample" do
    context "find BankAccount using the sample files" do
      it "returns ok" do

        result1 = @service.find_by_json_sample(@sample1_data)
        result2 = @service.find_by_json_sample(@sample2_data)

        expect(result1[:error]).to eq(false)
        expect(result1[:bank_account][:organization_name]).to eq(@sample1_data['organization_name'])
        expect(result2[:error]).to eq(false)
        expect(result2[:bank_account][:organization_name]).to eq(@sample2_data['organization_name'])
      end

      it "returns error" do
        result = @service.find_by_json_sample({})

        expect(result[:error]).to eq(true)
        expect(result[:bank_account]).to eq(nil)
        end

      it "returns error beacuse the bank doesn't exist in database" do
        result = @service.find_by_json_sample(@sample_bank_not_found_data['organization_name'])

        expect(result[:error]).to eq(true)
        expect(result[:bank_account]).to eq(nil)
      end
    end
  end
end
