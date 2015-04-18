require_relative "order_line"
class CustomerOrder < ActiveRecord::Base
  belongs_to :customer, :class_name => "Customer"
  has_many :order_lines, :foreign_key => "order_id", :class_name => "OrderLine"
  validates_uniqueness_of :order_no
  
  scope :in_cart, -> { where(status: "Pending") }
  
  def create_order_lines(cart)
    cart.each do |cart_item|
      order_line_params = {}
      product = Product.find(cart_item[:id].to_i)
      qty = cart_item[:qty].to_i
      order_line_params[:product_id] = product.id
      order_line_params[:qty] = qty
      order_line_params[:unit_price] = product.price
      order_line_params[:total_price] = product.price*qty
      self.order_lines.create!(order_line_params)
    end
  end
  
  def self.update_status(order_no, result)
    order = CustomerOrder.where(:order_no=>order_no).first
    unless order.nil?
      order.update_attribute(:status, result)
    end
    order
  end
end