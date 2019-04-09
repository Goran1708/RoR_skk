class PurchasesController < ApplicationController
  before_action :set_purchase_history, only: [:buy_ticket, :index]
  before_action :authenticate_user!

  def buy_ticket
    begin
    @order_item = PaymentServices::PurchaseTicket.call(params, @purchase_history, current_user)

    respond_to do |format|
      if @order_item
        format.html { redirect_to purchase_history_path, notice: 'You bought the ticket!' }
        format.json { render :show, status: :created, location: @order_item }
      else
        format.html { redirect_to root_path, alert: @order_item.errors.full_messages }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end

  rescue Error::CustomError, ActiveRecord::RecordInvalid => e
      respond_to do |format|
        format.html { redirect_to root_path, alert: e.message }
        format.json { head :no_content }
      end and return
    end
  end

  def cancel_ticket
    begin
    @order_item = PaymentServices::CancelTicket.call(params, current_user)

    if @order_item
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Ticket was successfuly canceled.' }
        format.json { head :no_content }
        format.js { flash.now[:notice] = 'Ticket was successfuly canceled.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to purchase_history_path, alert: @order_item.errors[:base].first }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js {}
      end
    end

    rescue Error::CustomError, ActiveRecord::RecordInvalid => e
      respond_to do |format|
        format.html { redirect_to root_path, alert: e.message }
        format.json { head :no_content }
        format.js { flash.now[:error] = e.message }
      end and return
    end
  end

  def index
  end

  private
    def set_purchase_history
      @purchase_history = current_user.purchase_history
    end
end
