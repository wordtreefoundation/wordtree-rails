class Query < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  belongs_to :book
  belongs_to :minus_shelf, :class_name => "Shelf", :foreign_key => "minus_shelf_id"
  belongs_to :baseline
  
end
