class Group < ActiveRecord::Base
  has_many :users, :through => :membership
  
end
