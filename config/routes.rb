Slideshow::Application.routes.draw do

  # use this
  # : automatically creates named routes for use in the controllers and views
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'contacts#new',         via: 'get'
  match '/',        to: 'static_pages#home',    via: 'get'
  match '/noname',  to: 'static_pages#noname',  via: 'get'
  # users
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/assets',  to: 'assets#update',        via: 'patch'
  match '/all_assets',  to: 'assets#index_all',  :as => "all_assets",    via: 'get'
  match '/share/:v/:id', to: 'galleries#shareview', :as => "share_for_gallery", via: 'get'  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: "static_pages#home"
  
  resources :contacts
  resources :users do
    resources :assets 
  end

  
  resources :sessions, only: [:new, :create, :destroy]
  #resources :assets 
  resources :galleries #, only: [:view , :create, :destroy]
  resources :password_resets
  
  # handle req to gallery / sort :json
  # maps to galleries#sort
  # sample URL /galleries/304/sort/id?asset[]=23&asset[]=21&asset[]=22&asset[]=19&asset[]=14&asset[]=13&asset[]=7&asset[]=6
  post 'galleries/:id/sort/:ids' => 'galleries#sort'#, {:sort => :get }


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
