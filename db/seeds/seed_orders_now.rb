# Seed orders
order_data = [
  { customerId: '123', customerName: 'John Doe', orderId: 'O011', totalInCents: 2000, date: DateTime.new(2023, 3, 15, 10, 30, 0) },
  { customerId: '123', customerName: 'John Doe', orderId: 'O012', totalInCents: 300, date: DateTime.new(2023, 3, 16, 12, 0, 0) },
  { customerId: '123', customerName: 'John Doe', orderId: 'O023', totalInCents: 100, date: DateTime.new(2023, 3, 17, 9, 45, 0) },
  # Add more order data as needed
]
  
order_data.each do |data|
  Order.create(data)
end