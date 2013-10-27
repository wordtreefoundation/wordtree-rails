class Shelf < ActiveRecord::Base
  has_many :books, :through => :copy
  belongs_to :user
  belongs_to :group
end
