# Seed orders
order_data = [
  { customerId: '123', customerName: 'John Doe', orderId: 'TO001', totalInCents: 2000, date: DateTime.new(2022, 3, 15, 10, 30, 0) },
  { customerId: '456', customerName: 'Jane Smith', orderId: 'TO002', totalInCents: 300, date: DateTime.new(2022, 3, 16, 12, 0, 0) },
  { customerId: '789', customerName: 'Mike Johnson', orderId: 'TO003', totalInCents: 100, date: DateTime.new(2022, 3, 17, 9, 45, 0) },

]
  
order_data.each do |data|
  Order.create(data)
end