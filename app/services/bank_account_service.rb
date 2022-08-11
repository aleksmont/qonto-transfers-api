class BankAccountService

  def find_by_json_sample (bank_account_info)
    begin
      bank_account = BankAccount
                       .where(organization_name: bank_account_info['organization_name'])
                       .where(bic: bank_account_info['organization_bic'])
                       .where(iban: bank_account_info['organization_iban'])
                       .take
      raise Exception if bank_account == nil
      { error: false, bank_account: bank_account }
    rescue Exception => e
      puts e
      { error: true, bank_account: nil }
    end
  end

end
