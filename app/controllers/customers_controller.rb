class CustomersController < ApplicationController
  def show
    user_info = Customers::CustomerService.new.user_info(params[:customerId])

    render json: {
      status: 200,
      data: {
        customerId: user_info[:customerId],
        customerName: user_info[:customerName],
        totalSpent: user_info[:totalSpent],
        currentTier: user_info[:currentTier],
        startDateOfTierCalculation: user_info[:startDateOfTierCalculation],
        amountSpentSinceStartDate: user_info[:amountSpentSinceStartDate],
        amountToReachnextTier: user_info[:amountToReachnextTier],
        nextYearDowngradeTier: user_info[:nextYearDowngradeTier],
        downgradeDate: user_info[:downgradeDate],
        amountToAvoidDowngrade: user_info[:amountToAvoidDowngrade]
      }
    }
  end
  
  def update_tier_users
    UpdateTierJob.perform_now
    render json: { message: 'User update job perfom now successfully' }
  end
end
  