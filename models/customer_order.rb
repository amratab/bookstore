class CustomerOrder < ActiveRecord::Base
  belongs_to :customer
  has_many :order_lines
  
  scope :in_cart, -> { where(status: "Pending") }
  
  def create_order_items
    order_line_params = {}
    order_line_params[:product_id] = params[:id]
    order_line_params[:qty] = params["qty"]
    order_line_params[:unit_price] = Product.find(params[:id]).price
    order_line_params[:total_price] = order_line_params[:unit_price]*qty
    self.order_lines.create!(order_line_params)
    self.update_attribute(:total, self.total + order_line_params[:total_price])
  end
  
  def update_order
    
  end
end