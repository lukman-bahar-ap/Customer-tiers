# Seed orders
order_data = [
  { customerId: '123', orderId: 'O001', totalInCents: 2000, date: DateTime.new(2022, 3, 15, 10, 30, 0) },
  { customerId: '456', orderId: 'O002', totalInCents: 300, date: DateTime.new(2022, 3, 16, 12, 0, 0) },
  { customerId: '789', orderId: 'O003', totalInCents: 100, date: DateTime.new(2022, 3, 17, 9, 45, 0) },
  # Add more order data as needed
]
  
order_data.each do |data|
  Order.create(data)
end