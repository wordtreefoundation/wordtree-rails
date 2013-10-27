class Comparison < ActiveRecord::Base
  belongs_to :query
  belongs_to :book
end
