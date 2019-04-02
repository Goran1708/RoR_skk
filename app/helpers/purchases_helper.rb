module PurchasesHelper

  def credit_card_valid?
    return params[:card_number] == "1234567812345678" && params[:cvv] == "123"
  end
end
