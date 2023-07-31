module Customers
  class CustomerService
    def increase_total_spent(customerId, totalInCents)
      customer = Customer.find_by(customerId: customerId)
      new_total_spent = customer.totalSpent + ( totalInCents / 100 ).to_f
      
      customer_tier = Customers::CustomerTierService.new.calculate_tier(
                                customerId, 
                                Date.new(DateTime.now.year, 1, 1)
                            )
      puts customer_tier
      new_tier = customer_tier['currentTier'] rescue customer.tier

      customer.totalSpent = new_total_spent
      customer.tier = new_tier
      customer.save   
    end  

    def user_info(customerId)
      customer = Customer.find_by(customerId: customerId)
      customer_tier = CustomerTier.find_by(customerId: customerId)
  
      {
        customerId: customer.customerId,
        customerName: customer.customerName,
        totalSpent: customer.totalSpent,
        currentTier: customer_tier.currentTier,
        startDateOfTierCalculation: customer_tier.startDateOfTierCalculation,
        amountSpentSinceStartDate: customer_tier.amountSpentSinceStartDate,
        amountToReachnextTier: customer_tier.amountToReachnextTier,
        nextYearDowngradeTier: customer_tier.nextYearDowngradeTier,
        downgradeDate: customer_tier.downgradeDate,
        amountToAvoidDowngrade: customer_tier.amountToAvoidDowngrade
      }
    end
  end
end  