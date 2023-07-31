module Orders
  class OrderService
    def create_order(order_form)
      order_form.save
    end

    def list_since_start_of_last_year(customerId)
      start_date = Date.new(Date.today.year, 1, 1)
      orders = Order.where(customerId: customerId, date: { :$gte => start_date })     
      orders
    end

    def find_order(id)
      order.find(id)
    end        
  end
end
