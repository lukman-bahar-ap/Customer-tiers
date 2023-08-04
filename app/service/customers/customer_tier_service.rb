module Customers
  class CustomerTierService

    def calculate_tier(customer_id, start_date_of_tier_calculation)
    # Calculate the amount spent by the customer since the start date of tier calculation    
    total_spent_in_cent = Order.where(customerId: customer_id, date: { :$gte => start_date_of_tier_calculation}).sum(:totalInCents)
    total_spent = centToDollars(total_spent_in_cent)

      #threshold in cent
      @tier_data = [
        { name: 'Gold', threshold: 50000, level: 3 },
        { name: 'Silver', threshold: 10000, level: 2 },
        { name: 'Bronze', threshold: 0, level: 1 },
      ]
    
      current_tier_info = current_tier_info(total_spent_in_cent)
      current_tier = current_tier_info[:name]

      amount_to_reach_next_tier = amount_to_reach_next_tier(current_tier_info[:level], total_spent_in_cent)
      next_year_downgrade_tier = next_year_downgrade_info(total_spent_in_cent, current_tier_info)
      downgrade_date = Date.new(start_date_of_tier_calculation.year + 1, 1, 1)
      amount_to_avoid_downgrade = amount_to_avoid_downgrade(total_spent_in_cent, current_tier_info)
    
      customer_tier_data = {
        customerId: customer_id,
        currentTier: current_tier,
        startDateOfTierCalculation: start_date_of_tier_calculation,
        amountSpentSinceStartDate: total_spent,
        amountToReachnextTier: amount_to_reach_next_tier,
        nextYearDowngradeTier: next_year_downgrade_tier,
        downgradeDate: downgrade_date,
        amountToAvoidDowngrade: amount_to_avoid_downgrade
      }
      #puts customer_tier_data
     # Rails.logger.info "calculate_tier: #{customer_tier_data}"

      # Update or create the customer_tier record
      customer_tier = CustomerTier.find_or_create_by(customerId: customer_id)
      if customer_tier.update(customer_tier_data)
        #response
        customer_tier_data
      end 
    end

    private 

    def centToDollars(cent)
      (cent / 100).to_f
    end

    def current_tier_info(total_spent_in_cent)
      @tier_data.find { |tier| total_spent_in_cent >= tier[:threshold] }
    end

    def amount_to_reach_next_tier(current_level, total_spent_in_cent)
      return 0 if current_level == 3

      tier_filter = @tier_data.find { |tier| tier[:level] == current_level.to_i + 1}
      return 0 if tier_filter[:threshold].to_i < total_spent_in_cent

      centToDollars(tier_filter[:threshold] - total_spent_in_cent)
    end

    def next_year_downgrade_info(total_spent_in_cent, current_tier_info)
      if total_spent_in_cent > current_tier_info['threshold'].to_i
        nil
      else
        return current_tier_info[:name] if current_tier_info[:level] == 1

        tier_filter =  @tier_data.find { |tier| tier[:level] == (current_tier_info[:level] - 1) }
        tier_filter[:name]
      end
    end

    def amount_to_avoid_downgrade(total_spent_in_cent, current_tier_info)
      if total_spent_in_cent > current_tier_info['threshold'].to_i
        0
      else
        centToDollars(current_tier_info['threshold'].to_i - total_spent_in_cent)
      end
    end

  end
end