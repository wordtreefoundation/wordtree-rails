ActiveAdmin.register User do
  index do
    column :name
    column :email
    column :uid
    column :provider
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :name
  filter :email
  filter :provider, :as => :select

  form do |f|
    f.inputs "Name and Login" do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit user: [:name, :email, :password, :password_confirmation]
    end
  end
end
