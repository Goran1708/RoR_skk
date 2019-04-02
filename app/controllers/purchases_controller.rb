class PurchasesController < ApplicationController
  include PurchasesHelper
  before_action :set_purchase_history, only: [:buy_ticket]
  before_action :set_ticket, only: [:show]

  def buy_ticket
    @ticket = Ticket.find(params[:ticket_id])
    if credit_card_valid?
      if (@ticket.quantity <= 0)
        respond_to do |format|
          format.html { redirect_to root_path, alert: 'Out of tickets.' }
          format.json { head :no_content }
        end and return
      end

      @order_item = @purchase_history.purchase_ticket(@ticket)

      respond_to do |format|
        if @order_item.save
          format.html { redirect_to purchase_history_path, notice: 'You bought the ticket!' }
          format.json { render :show, status: :created, location: @line_item }
        else
          format.html { render :new }
          format.json { render json: @order_item.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, alert: 'Bad credit card detail.' }
        format.json { head :no_content }
      end
    end
  end

  def cancel_ticket
    @order_item = OrderItem.find(params[:order_item_id])
    @order_item.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def index
    @purchase_history = current_user.purchase_history
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def set_purchase_history
      if (current_user.purchase_history != nil)
        @purchase_history = PurchaseHistory.find_by(id: current_user.purchase_history.id)
      else
        @purchase_history = PurchaseHistory.new(user_id: current_user.id)
        @purchase_history.save!
      end
    end
end
