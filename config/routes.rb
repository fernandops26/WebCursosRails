Rails.application.routes.draw do
  resources :courses
  resources :categories
  resources :users

  #rutas de usuario
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'home', to: 'users#index'
  delete 'logout', to: 'user_sessions#destroy'

  #rutas de admin
  get 'admin/login', to:'admin_sessions#new'
  post 'admin/login', to: 'admin_sessions#create'
  get 'admin/home', to: 'admins#index'
  get 'admin/logout', to: 'admin_sessions#destroy'



  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'static#index'

   get 'contacto', to:'static#contact'

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
