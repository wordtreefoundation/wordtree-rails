class Book < ActiveRecord::Base
  has_many :copies
  has_many :shelves, :through => :copies
  
end
