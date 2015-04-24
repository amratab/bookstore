This is a e-commerce website for selling books "bookstore":
Used : javascript, ruby, sinatra

User functionalities:
1) Register using sign up link on the first page.(located in upper right hand menu)
2) Once registered, sign in to use the website.
3) User can see his cart and orders at any time using the upper right hand side menu.

Product functionalities:
1) Products present are listed on entry page.
2) From entry page, following operations can be done on a product:
  i) View details.
  ii) Edit the product(Only for logged in user)
  iii_ Add item to cart(Only for logged in user)
  iv) Add a new product.(Only for logged in user)

Placing an order:-
1)To place an order, first add the items to your cart.
2)Go to cart page from the menu
3) Click on Order.
4) Provide your address.
5) Click on Place order.
6) Now you are redirected to payment gateway service where you have to enter your card details. 
7) Click on pay.
8) Next page shows whether your payment was success/failure and then redirects you back to your order details in bookstore.

Payment Gateway:-
Payment gateway is a separate ruby-sinatra project which should be run on port 9001. For payment, params get posted to this gateway and after processing, it posts back to the callback of website where the order status gets updated.

Features:-
1) Current user and cart are maintained in session. Once an order is placed, session is cleared of cart.
2) Email is unique for all users.
3) User can edit quantity of items in cart and view the amount changes simultaneously.

Additions:-
1) Added a new field to order table called status. When the order is created, the status is PENDING and after payment success/failure it gets updated according to the result i.e. success or failure.

How to deploy:
DB:- 
Populate correct db settings in bookstore/config.ru or follow the steps given below:
run mysql -u root -p
Create user with user/password credentials:
CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
Create database:
CREATE DATABASE bookstoredb;
Grant privileges to user:
GRANT ALL PRIVILEGES ON bookstoredb.* TO 'user'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION;
Run migrate script:
mysql -u user -p bookstoredb < <path_to_migrate.sql>

Setting up project:
For bookstore:
1) Bundle install
2) rackup (this will start the server on port 9292)
for payment_gateway
1)Bundle install
2) rackup -p 9001(This is the port I have assumed payment gateway runs on. If you want to change the port, change port number in bookstore/views/buy.haml )

Projects will be up and ready. Now run http://localhost:9292/ on your browser to start bookstore

Improvements required but not implemented because of time constraint:-
1) Ui improvements of course.
2) Products index could use pagination.
3) Add to cart should be allowed without login and session data should be transferred on login. 
4) Products new/edit should be allowed only for admin users. Currently there is no separation on type of users.
5) Address is not getting saved in db. Its dummy for now. 
6) There are many details missing like currency, tax levied etc.
7) Configuration should be picking url of payment gateway etc.
 
