require 'qless/server'

CompareTexts::Application.routes.draw do
  # Welcome page
  root :to => "welcome#index"

  # OmniAuth
  # get "/auth/signin", to: "sessions#index", as: "signin"
  # get "/auth/signout", to: "sessions#destroy", as: "signout"
  # get "/auth/:provider/callback", to: "sessions#create"

  # ActiveAdmin
  # p ActiveAdmin::Devise.config
  # devise_for :users #, ActiveAdmin::Devise.config
  devise_for :users, :controllers => {
    :sessions => "sessions",
    :omniauth_callbacks => "omniauth_callbacks"
  }

  ActiveAdmin.routes(self)

  # Admin pages for Qless job queue server at /jobs/*
  # get "/jobs", to: Qless::Server.new(Qless::Client.new), anchor: false

  # Resources
  resources :books
  resources :shelves

  get "/shelves/:id/archive_org", to: "archive_org#setup", as: "archive_org_setup"
  post "/shelves/:id/archive_org", to: "archive_org#initiate", as: "archive_org_initiate"
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
