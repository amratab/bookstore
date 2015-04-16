class Product < ActiveRecord::Base
  belongs_to :order_line
  
  def self.list( page)
    Product.all
  end
  
  def self.find_product( id )
    Product.find(id)
  end
  
  def self.update_product( params )
    begin
      product = Product.find_product(params[:id])
      params = params.select {|k,v| ["name", "price", "description", "status"].include?(k) }
      params[:price] = params["price"].to_f
      product.update(params)
      return {:success => true}
    rescue => e
      return {:success => false, :message => e.message}
    end
  end
  
  def self.create_product( params )
    begin
      Product.create!(params)
      return {:success => true}
    rescue => e
      return {:success => false, :message => e.message}
    end
  end
end