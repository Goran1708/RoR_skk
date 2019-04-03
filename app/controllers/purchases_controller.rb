class PurchasesController < ApplicationController
  before_action :set_purchase_history

  def buy_ticket
    begin
    @order_item = PaymentServices::Payment.call(params, @purchase_history)

    respond_to do |format|
      if @order_item.save
        format.html { redirect_to purchase_history_path, notice: 'You bought the ticket!' }
        format.json { render :show, status: :created, location: @order_item }
      else
        format.html { redirect_to root_path, alert: @order_item.errors.full_messages }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end

    rescue Error::CustomError => e
      respond_to do |format|
        format.html { redirect_to root_path, alert: e.message }
        format.json { head :no_content }
      end and return
    end
  end

  def cancel_ticket
    @order_item = OrderItem.find(params[:order_item_id])
    if @order_item.destroy
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Order was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, alert: @order_item.errors[:base].first }
        format.json { head :no_content }
      end
    end
  end

  def index
  end

  private
    def set_purchase_history
      @purchase_history = current_user.purchase_history
    end
end
