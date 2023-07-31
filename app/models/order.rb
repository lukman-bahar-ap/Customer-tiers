class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  field :customerId, type: String
  field :customerName, type: String
  field :orderId, type: String
  field :totalInCents, type: Integer
  field :date, type: DateTime

  after_save :update_customer_tier

  private

  def update_customer_tier
    Customers::CustomerService.new.increase_total_spent(self.customerId, self.totalInCents)
  end
end