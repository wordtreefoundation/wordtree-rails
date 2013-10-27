class Shelf < ActiveRecord::Base
  has_many :books, :through => :copy
end
