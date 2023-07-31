module Orders
  class OrderForm 
    include ActiveModel::Model

    attr_accessor :customerId,
                  :customerName,
                  :orderId,
                  :totalInCents,
                  :date

   validates :customerId, :orderId, :totalInCents, :date, presence: true

    def save
      return false unless valid?

      order = Order.new(order_params)
      if order.save
        # Recalculate customer's tier based on total spending
        # Customers::CustomerService.new.increase_total_spent(
        #   order_params[:customerId], 
        #   order_params[:totalInCents]
        # )
        true
      else
        model_errors(order)
      end
    end

    private

    def order_params
      {
        customerId: self.customerId,
        customerName: self.customerName,
        orderId: self.orderId,
        totalInCents: self.totalInCents,
        date: self.date
      }
    end

    def model_errors(order)
      order.errors.messages.each do |key, value|
        errors.add(key, value.join(', '))
      end && false
    end
  end
end
