class Product < ActiveRecord::Base
  
  def self.list( page)
    Product.all
  end
end