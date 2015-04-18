This is a e-commerce website for selling books:
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
1) Current user and cart are maintained in session.
2) Email is unique for all users.

Additions:-
1) Added a new field to order table called status. When the order is created, the status is PENDING and after payment success/failure it gets updated according to the result i.e. success or failure.
 
