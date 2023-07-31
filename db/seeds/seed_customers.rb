customer_data = [
  { customerId: '123', customerName: 'John Doe', totalSpent: 0 },
  { customerId: '456', customerName: 'Jane Smith', totalSpent: 0 },
  { customerId: '789', customerName: 'Mike Johnson', totalSpent: 0 },
  # Add more customer data as needed
]
  
customer_data.each do |data|
  customer = Customer.create(data)
  customer.save
end
