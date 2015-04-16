require_relative "models/product"
require_relative "models/customer"
set :haml, :format => :html5

before do
  current_user_id = session[:user_id]
  unless current_user_id.blank?
    @current_user = Customer.get(current_user_id) 
  end
end

get "/" do
  page = @params[:page]
  @products = Product.list(page)
  haml :"products/index"
end

# get '/hello/:name' do
  # @name = params[:name]
  # @values = {
    # 1 => "cake",
    # 2 => "cookies"
  # }
  # haml :index
# end

get "/placeorder" do
  
end
