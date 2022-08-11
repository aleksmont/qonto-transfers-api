require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  before(:all) do
    sample1_file = File.read('./spec/fixtures/sample1.json')
    @sample1_data = JSON.parse(sample1_file)

    sample2_file = File.read('./spec/fixtures/sample2.json')
    @sample2_data = JSON.parse(sample2_file)

    sample_balance_file = File.read('./spec/fixtures/sample_balance.json')
    @sample_balance_data = JSON.parse(sample_balance_file)
  end

  describe "POST /transactions" do
    let!(:sample1_params) { @sample1_data }
    let!(:sample2_params) { @sample2_data }
    let!(:sample_balance_params) { @sample_balance_data }

    it "Sample 1 OK" do
      post "/transactions", params: sample1_params
      body = JSON.parse(response.body)

      expect(response.status).to eq(201)
      expect(body['error']).to eq(false)
    end

    it "Sample 2 OK" do
      post "/transactions", params: sample2_params
      body = JSON.parse(response.body)

      expect(response.status).to eq(201)
      expect(body['error']).to eq(false)
    end

    it "Sample Not Enough Balance" do
      post "/transactions", params: sample_balance_params

      expect(response.status).to eq(422)
    end

  end
end
