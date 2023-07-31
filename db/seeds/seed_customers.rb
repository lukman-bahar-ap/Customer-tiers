customer_data = [
  { customerId: '123', customerName: 'John Doe', totalSpent: 100 },
  { customerId: '456', customerName: 'Jane Smith', totalSpent: 500 },
  { customerId: '789', customerName: 'Mike Johnson', totalSpent: 200 },
  # Add more customer data as needed
]
  
customer_data.each do |data|
  customer = Customer.create(data)
  customer.tier = 'Bronze'
  customer.save
end
