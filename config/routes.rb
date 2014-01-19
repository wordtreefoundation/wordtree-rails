require 'qless/server'
require 'uri'

redis_uri = URI(ENV['REDIS_URL'] || 'redis://localhost:6379')
$stderr.puts ENV.inspect

CompareTexts::Application.routes.draw do
  # Welcome page
  root :to => "welcome#index"

  # ActiveAdmin
  devise_for :users, :controllers => {
    :sessions => "sessions",
    :omniauth_callbacks => "omniauth_callbacks"
  }

  ActiveAdmin.routes(self)

  # Admin pages for Qless job queue server at /jobs/*
  get "/jobs", to: Qless::Server.new(Qless::Client.new(:host => redis_uri.host, :port => redis_uri.port)), anchor: false, as: "qless_jobs"

  # Resources
  resources :books
  resources :shelves

  get "/shelves/:id/archive_org", to: "archive_org#setup", as: "archive_org_setup"
  post "/shelves/:id/archive_org", to: "archive_org#initiate", as: "archive_org_initiate"
  
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
