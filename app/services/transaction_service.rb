class TransactionService

  def perform (bank_account, transactions)
    begin
      raise Exception if transactions.count < 1

      total_amount = transactions.sum { |t| t['amount'].to_i }

      raise Exception if bank_account.balance_cents < total_amount

      transactions.each_with_index do |t, k|
        amount = -(t["amount"].to_i)

        Transaction.create(
          counterparty_name: t["counterparty_name"],
          counterparty_iban: t["counterparty_iban"],
          counterparty_bic: t["counterparty_bic"],
          amount_cents: amount,
          amount_currency: t["currency"],
          bank_account_id: bank_account.id,
          description: t["description"]
        )

        bank_account.balance_cents += amount
      end

      bank_account.save
      { error: false, msg: "Everything is ok!" }
    rescue Exception => e
      { error: true, msg: e.message }
    end
  end

end
