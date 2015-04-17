class Customer < ActiveRecord::Base
  
  has_many :customer_orders
  
  def self.get( id )
    Customer.find(id)
  end
  
  def self.create_new(params)
    begin
      customer = Customer.create!(:firstname=>params[:firstname], :lastname => params[:lastname], :email => params[:email], :password => params[:password])
      return {:success => true, :message => "success", :id => customer.id }
    rescue => e
      return {:success => false, :message => e.message}
    end
  end
  
  def self.login( params )
    begin 
      customer = Customer.where(:email => params[:email]).first
      unless customer.nil?
        if params[:password] == customer.password
          return {:success => true, :message => "Success!", :id => customer.id}
        end
      else
        return {:success => false, :message => "User not registered with us!"}
      end
      return {:success => false, :message => "Wrong password!"}
    rescue => e
      return {:success => false, :message => e.message}  
    end
  end
  
  def add_to_cart()
    order = self.customer_orders.pending.first
    if order.nil?
      order = self.customer_orders.create!(:date => Date.today)
    end
    order.create_order_items(params)
  end
end