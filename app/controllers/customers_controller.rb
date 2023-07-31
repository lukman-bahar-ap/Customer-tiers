class CustomersController < ApplicationController
  def show
    customer = Customer.find_by(customerId: params[:customerId])
    customer_tier = customer.customer_tier

    render json: {
      customerId: customer.customerId,
      customerName: customer.customerName,
      totalSpent: customer.totalSpent,
      currentTier: customer_tier.current_tier,
      startDateOfTierCalculation: customer_tier.startDateOfTierCalculation,
      amountSpentSinceStartDate: customer_tier.amountSpentSinceStartDate,
      amountToReachNextTier: customer_tier.amountToReachNextTier,
      nextYearDowngradeTier: customer_tier.nextYearDowngradeTier,
      downgradeDate: customer_tier.downgradeDate,
      amountToAvoidDowngrade: customer_tier.amountToAvoidDowngrade
    }
  end
  
  def update_tier_users
    # Enqueue the background job
    UpdateTierJob.perform_now
    render json: { message: 'User update job enqueued successfully' }
  end
end
  