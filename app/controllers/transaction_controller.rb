class TransactionController < ApplicationController

  def create
    begin
      @transaction_service = TransactionService.new
      @bank_account_service = BankAccountService.new

      result_bank_account = @bank_account_service.find_by_json_sample(bank_account_params)
      raise Exception if result_bank_account[:error] == true

      result_transaction = @transaction_service.perform(result_bank_account[:bank_account], transactions_params.to_h['credit_transfers'])
      raise Exception if result_transaction[:error] == true

      render json: result_transaction, status: :created
    rescue Exception => e
      render json: { errors: e.message }, status: :unprocessable_entity
    end
  end

  private

  def bank_account_params
    params.permit(:organization_name, :organization_bic, :organization_iban)
  end

  def transactions_params
    params.permit(credit_transfers: [[:amount, :currency, :counterparty_name, :counterparty_bic, :counterparty_iban, :description]])
  end
end