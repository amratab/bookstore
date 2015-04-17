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
  
  def self.populate_cart_items(items)
    if items.nil?
      return []
    else
      populated_cart = []
      items.each do |item|
        product = find_product(item[:id])
        price = product.price
        qty = item[:qty].to_f
        populated_cart.push({
          :id => product.id,
          :name => product.name,
          :unit_price => product.price,
          :qty => qty,
          :total_price => product.price*qty
        })
      end
      populated_cart
    end
  end
  
end