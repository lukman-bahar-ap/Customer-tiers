class CustomerTier
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :customerId, type: String
  field :currentTier, type: String
  field :startDateOfTierCalculation, type: Date
  field :amountSpentSinceStartDate, type: Integer
  field :amountToReachnextTier, type: Integer
  field :nextYearDowngradeTier, type: String
  field :downgradeDate, type: Date
  field :amountToAvoidDowngrade, type: Integer

  belongs_to :customer 
end