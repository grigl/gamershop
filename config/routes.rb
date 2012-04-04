Gamershop::Application.routes.draw do
  get "searches/show"

  root to: 'store#index'

  match '(:platform)/(:genre)' => 'store#index', constraints: {
                                                   platform: /#{Product.platforms.join('|')}/,
                                                   genre: /#{Product.genres.join('|')}/ }, as: 'store'
  match ':platform/:genre/:id' => 'store#show', constraints: {
                                                   platform: /#{Product.platforms.join('|')}/,
                                                   genre: /#{Product.genres.join('|')}/,
                                                   :id => /\d+/ }, as: 'store_item'

  resources :line_items
  post 'add_to_cart/:id' => 'line_items#create', as: 'add_to_cart'

  resources :carts

  match 'how_to_buy' => 'pages#how_to_buy', as: 'how_to_buy'
  match 'delivery' => 'pages#delivery', as: 'delivery'
  match 'about_us' => 'pages#about_us', as: 'about_us'

  scope :module => :admin do
    scope 'admin' do
      resources :users
      resources :products

      match '/' => 'users#index'
    end
  end

  resources :orders
  get 'profile/orders/:id' => 'orders#show', as: 'order'
  post 'profile/orders/:id' => 'orders#purchase', as: 'purchase'

  resources :sessions
  delete 'logout' => "sessions#destroy", as: 'logout'

  get 'search' => "searches#show", as: 'search'

  resources :profiles
  get 'profile' => "profiles#show", as: 'profile'

  get 'activate_user/:activation_token' => 'profiles#activate', as: 'activate_profile'
  post 'password_reset' => 'profiles#password_reset', as: 'password_reset'
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
  # match ':controller(/:action(/:id))(.:format)'
end
