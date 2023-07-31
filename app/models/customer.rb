class Customer
  include Mongoid::Document
  include Mongoid::Timestamps

  has_one :customer_tier

  field :customerId, type: String
  field :customerName, type: String
  field :totalSpent, type: Integer, default: 0
  field :tier, type: String, default: 'Bronze'

end