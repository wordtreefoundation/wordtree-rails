class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, :through => :memberships
  
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

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end
end
