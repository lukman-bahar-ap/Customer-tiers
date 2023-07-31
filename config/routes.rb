Rails.application.routes.draw do
  post 'orders', to: 'orders#create'
  get 'customers/:customerId', to: 'customers#show'
  get 'customers/update_tier_users', to: 'customers#update_tier_users'
  get 'orders/:customerId', to: 'orders#list'
end
