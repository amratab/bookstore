require 'json'
require_relative "models/product"
require_relative "models/customer"
set :haml, :format => :html5

before do
  current_user_id = session[:customer_id]
  puts current_user_id
  unless current_user_id.blank?
    @current_user = Customer.get(current_user_id) 
  end
end

def store_user_in_session(id)
  session[:customer_id] = id
end

def add_to_cart(params)
  if session[:cart].nil?
    session[:cart] = []
  end
  params[:id] = params[:id].to_i
  product_hash = session[:cart].select{|item| item[:id] == params[:id]}
  qty = 1
  unless product_hash.blank?
    product_hash = product_hash.first
    qty = product_hash[:qty]+1
    session[:cart].delete(product_hash)
  end
  session[:cart].push({
    :id => params[:id],
    :qty => qty
  })
end

def update_cart(params)
  product_hash = session[:cart].select{|item| item[:id] == params[:id].to_i}.first
  session[:cart].delete(product_hash)
  session[:cart].push({
    :id => params[:id].to_i,
    :qty => params[:qty].to_i
  })
end

get "/" do
  page = @params[:page]
  @products = Product.list(page)
  haml :"products/index"
end

post "/signup" do
  result = Customer.create_new(params)
  if result[:success]
    store_user_in_session(result[:id])
    content_type :json
    { :result => 'success'}.to_json
  else
    content_type :json
    { :result => 'failure', :message => result[:message] }.to_json
  end
end

post "/signin" do
  result = Customer.login(params)
  if result[:success]
    store_user_in_session(result[:id])
    content_type :json
    { :result => 'success'}.to_json
  else
    content_type :json
    { :result => 'failure',:message => result[:message]}.to_json
  end
end

post "/logout" do
  session[:customer_id] = nil
  redirect "/" 
end

# Cart urls
post "/product/:id/addtocart" do
  add_to_cart(params)
  content_type :json
  { :result => 'success'}.to_json
end

get "/cart" do
  @cart_items = Product.populate_cart_items(session[:cart])
  haml :"customers/cart"
end

post "/cart/update" do
  update_cart(params)
  content_type :json
  { :result => 'success'}.to_json
end

#Product urls
get "/product/:id/show" do
  @product = Product.find_product(params[:id])
  haml :"products/show"
end

get "/product/new" do
  haml :"products/new"
end

get "/product/:id/edit" do
  @product = Product.find_product(params[:id])
  haml :"products/edit"
end

post "/product/:id/update" do
  result = Product.update_product(params)
  if result[:success]
    store_user_in_session(result[:id])
    content_type :json
    { :result => 'success'}.to_json
  else
    content_type :json
    { :result => 'failure',:message => result[:message]}.to_json
  end
end

post "/product/create" do
  result = Product.create_product(params)
  if result[:success]
    store_user_in_session(result[:id])
    content_type :json
    { :result => 'success'}.to_json
  else
    content_type :json
    { :result => 'failure',:message => result[:message]}.to_json
  end 
end

#Order urls
 
post "/placeorder" do
  @order = @current_user.place_order(session[:cart])
  session[:cart] = nil
  haml :"customer_orders/buy"
end


post "/pgcallback" do
  @result = params[:result]
  @order_no = params[:order_id]
  @order = CustomerOrder.update_status(@order_no, @result)
  haml :"customer_orders/result"
end

get "/orders" do
  @orders = @current_user.customer_orders.order(date: :desc)
  haml :"customer_orders/index"
end

get "/order/:id/show" do
  @order = CustomerOrder.find(params[:id])
  haml :"customer_orders/show"
end
