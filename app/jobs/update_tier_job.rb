class UpdateTierJob < ApplicationJob
  queue_as :default
  
  def perform
    # Get the total number of users
    total_users = Customer.count

    # spare beacause start in end minutes of the end of the year
    spare_new_year_changes = DateTime.now.midnight - 7.days
    start_date = Date.new(spare_new_year_changes.year, 1, 1)
    batch_size = 1000
    # Process each user in batches
    fetch_users_with_pagination(total_users, start_date, batch_size)
  end

  private

  def fetch_users_with_pagination(total_users, start_date, batch_size = 1000)

    offset = 0
    while offset < total_users
      # Fetch the current batch of users
      users = Customer.offset(offset).limit(batch_size)
     
      # Process each user in the batch
      users.each do |user|

        customerId = user[:customerId]
        total_spent_in_cent = Order.where(customerId: customerId, date: { :$gte => start_date}).sum(:totalInCents)
        # Save the updated user record
        customer_tier = Customers::CustomerTierService.new.calculate_tier(
                          customerId, 
                          total_spent_in_cent,
                          Date.new(Date.today.year, 1, 1)
                        )
        new_tier = customer_tier['currentTier'] rescue user.tier

        user.totalSpent = total_spent_in_cent / 100
        user.tier = new_tier
        user.save
      end
  
      # Increment the offset for the next batch
      offset += batch_size
    end
  end
end
