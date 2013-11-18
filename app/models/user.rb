class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :registerable
  devise :omniauthable, :omniauth_providers => [:github, :twitter]

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

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token["info"]
    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password.
      User.create!(:email => data["email"], :password => Devise.friendly_token[0,20])
    end
  end

end
