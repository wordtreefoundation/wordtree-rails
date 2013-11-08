class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
  has_many :memberships
  has_many :groups, :through => :memberships
  has_many :archive_org_transfers
  
  # User becomes an admin
  def promote!
    groups << Group.find(Settings.admin_group_id)
  end

  def admin?
    groups.find(Settings.admin_group_id)
    true
  rescue ActiveRecord::RecordNotFound
    false
  end

  def logged_in?
    not new_record?
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end
end
