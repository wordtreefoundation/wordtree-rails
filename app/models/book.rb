class Book < ActiveRecord::Base
  has_many :shelves, :through => :copy
  
end
