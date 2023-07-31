module Orders
  class OrderService
    def create_order(order_form)
      order_form.save
    end

    def list_since_start_of_last_year(customerId, page = 0)
      startOfLastYear = "#{Date.today.year}-01-01"
      orders = Order.where(customerId: customerId, date: { :$gte => startOfLastYear})     
      [orders]
    end

    def find_order(id)
      order.find(id)
    end        
  end
end
