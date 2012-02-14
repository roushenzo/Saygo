Saygo::Application.routes.draw do
  Mercury::Engine.routes

  resource :search, :only => [:show], :controller => 'search'
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  root :to => 'countries#index'
  match 'categories/:category_id/custom_fields.json', :to => 'custom_fields#index', :as => :category_custom_fields, :via => :get, :format=>false, :defaults=>{:format=>'json'}
  match 'custom_fields/:custom_field_id/values.json', :to => 'values#index', :as => :custom_field_values, :via => :get, :format=>false, :defaults=>{:format=>'json'}
  match 'countries/:country_id/cities', :to => 'cities#index', :as => :country_cities, :via => :get
  match ':country_id(/:city_id(/:category_id(/:id)))', :to => 'pages#show', :as => :page, :via => :get
  match 'countries/:country_id/cities', :to => 'cities#index', :as => :country_cities, :via => :get
  match 'pages/:page_id/comments', :to => 'comments#create', :as => :page_comments, :via => :post
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
