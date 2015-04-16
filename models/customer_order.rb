class CustomerOrder < ActiveRecord::Base
  belongs_to :customer
  has_many :order_lines
end