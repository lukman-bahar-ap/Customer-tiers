# README

INTRODUCTION

Requirement : 
    Ruby 3.0.3
    Ruby on Rails 7
    Mongodb
    PostMan (for test endpoint)


cronjob file attached in project-folder/cronjob.sh

SET UP before run on Development : 
customers
1. first install bundle using `bundle install`

<br>

2. abjust your auth mongodb on file config/mongoid.yml
    change : 
     a. host: - localhost:27018 (change the port, i am usually using docker, so that on port 27018, default 27017)
     b. user: 'loyalty' (change with your user mongodb)
     c. password: 'success2023' (change with your password mongodb)
<br>

3. seeding data first, using command :

    `bundle exec rake db:seed:single SEED=seed_customers`
    `bundle exec rake db:seed:single SEED=seed_orders`
<br>

4. run backend in development mode :
    `rails s`
<br>

5. open your postman : 

    1. An endpoint we can call to report a completed order, which should save the order in a database and recalculate the customer's tier. The body of this request will be in the form: { "customerId": "123", "customerName": "Taro Suzuki", "orderId": "T123", "totalInCents": 3450, "date": "2022-03-04T05:29:59.850Z" }

        POST => `http://127.0.0.1:3000/orders/`

    -----------------------

    2. A way to recalculate the current tier of each customer at the end of each year (for example, you could create a cron job and give instructions of how and when to execute it)

        GET => `http://127.0.0.1:3000/customers/update_tier_users` 

    ---------------------------
    get 'orders/:customerId', to: 'orders#list'

    3. An endpoint which returns information about a customer when given their ID. It should return at least the customer's

        GET => `http://127.0.0.1:3000/customers/[ID_CUSTOMERS]` 

    ----------------------------
    4. An endpoint which lists the customer's orders since the start of last year, including the order ID, date and order total

        GET => `http://127.0.0.1:3000/orders/[ID_CUSTOMERS]` 

<br>

6. for cronjob :
   1. open your terminal
   2. if OS is linux: `crontab -e`
   3. copy commmand cronjob on file cronjob.sh
   4. exit and save
   5. reload crontab using `sudo service cron reload`

   NB : cron will be hit endpoint for running job in background to update all customers with pagination process