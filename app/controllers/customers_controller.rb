class CustomersController < ApplicationController
  def show
    customer = Customer.find_by(customerId: params[:customerId])
    customer_tier = CustomerTier.find_by(customerId: params[:customerId])

    render json: {
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
  
  def update_tier_users
    UpdateTierJob.perform_now
    render json: { message: 'User update job perfom now successfully' }
  end
end
  