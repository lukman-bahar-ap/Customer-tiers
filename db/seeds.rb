customer_data = [
  { customerId: '123', customerName: 'John Doe', totalSpent: 1000 },
  { customerId: '456', customerName: 'Jane Smith', totalSpent: 500 },
  { customerId: '789', customerName: 'Mike Johnson', totalSpent: 200 },
]

customer_data.each do |data|
  customer = Customer.create(data)
  customer.tier = calculate_tier(data[:totalSpent], '2021-01-01')
  customer.save
end



  