class Customer < ActiveRecord::Base
  
  def self.get( id )
    User.find(id)
  end
end