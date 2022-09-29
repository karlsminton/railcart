## RailCart

An e-commerce system, built in Ruby on Rails, supporting;
- Registered customers & addresses
- Products
- Categories
- Orders
- Cart
- Checkout
- PayPal Integration

#### TODO

- Send correct line totals to PayPal
- Save addresses to customer on order send
- Support nil customer reference on addresses
- Save addresses against orders
- Restrict access for only admins to create/new methods on controllers
- Allow users to view their orders on account page
- Create config reader to get PayPal credentials (currently hardcoded)
- Use rubocop to make methods smaller
- Remove logic from templates and place into helpers