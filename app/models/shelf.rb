class Shelf < ActiveRecord::Base
  has_many :copies
  has_many :books, :through => :copies
  has_many :archive_org_transfers
  belongs_to :user
  belongs_to :group
end
