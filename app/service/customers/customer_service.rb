module Customers
  class CustomerService
    def increase_total_spent(customerId, totalInCents)
      customer = Customer.find_by(customerId: customerId)
      new_total_spent = customer.totalSpent + ( totalInCents / 100 )
      
      customer_tier = Customers::CustomerTierService.new.calculate_tier(
                                customerId, 
                                totalInCents,
                                Date.new(Date.today.year, 1, 1)
                            )
      puts customer_tier
      new_tier = customer_tier['currentTier'] rescue customer.tier

      customer.totalSpent = new_total_spent
      customer.tier = new_tier
      customer.save   
    end  
  end
end  