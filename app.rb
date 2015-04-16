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


get "/placeorder" do
  
end
