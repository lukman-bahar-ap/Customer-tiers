class OrdersController < ApplicationController

  def create
    order_form = Orders::OrderForm.new(order_params)

    message = if Orders::OrderService.new.create_order(order_form)
                  success_response
              else
                  failed_response.merge(message: order_form.errors.full_messages.join(', '))
              end

    render json: message
  end

  def list
    orders = Orders::OrderService.new.list_since_start_of_last_year(params[:customerId])  
    render json: { customerId: params[:customerId], orders: orders }
  end

  private

  def order_params
    params.require(:order).permit(:customerId, :customerName, :orderId, :totalInCents, :date)
  end

end