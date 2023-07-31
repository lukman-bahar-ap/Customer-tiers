class Customer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :customerId, type: String
  field :customerName, type: String
  field :totalSpent, type: Float, default: 0
  field :tier, type: String, default: 'Bronze'

end