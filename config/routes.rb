Rails.application.routes.draw do

  get 'errors/not_found'

  get 'errors/internal_server_error'

  get 'subsidiaries/index'

  resources :programations
  scope '/management' do
    resources :modalities, :institutions, :courses, :categories,:coordinators,:users,:people
  end

 
  #rutas de usuario
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  get 'signup', to: 'static#new'
  post 'signup', to: 'static#create'
  get 'home', to: 'users#index'
  delete 'logout', to: 'user_sessions#destroy'

  #rutas de admin
  get 'admin/login', to:'admin_sessions#new'
  post 'admin/login', to: 'admin_sessions#create'
  get 'admin/home', to: 'admins#index'
  get 'admin/profile', to: 'admins#profile'
  patch 'admin/profile', to:'admins#update_profile'
  get 'admin/logout', to: 'admin_sessions#destroy'



  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'static#index'
   get 'contacto', to:'static#contact'
   post 'contacto', to:'static#create_query_contact'
   get 'cursos', to:'static#courses'
   get 'curso/:id', to: 'static#show' ,as: 'curso'

   get 'aplicar', to: 'static#aplicar'

   post 'aplicar', to: 'static#add_aplicator'

   get 'coordinadores', to: 'static#coordinators'

   get 'search_curso', to: 'static#search_courses'

   get 'verificar', to: 'static#verify'

   get 'pagos', to: 'static#buy_methods'

   post 'categories/update_destacar', to: 'categories#update_destacar'

   get 'management/contact', to:'contact_queries#index'

   get 'management/contact/:id', to:'contact_queries#show'

   post 'management/contact/update_leido', to: 'contact_queries#update_leido'


   get 'management/subsidiaries', to:'subsidiaries#index'

   get 'management/subsidiaries/:id', to:'subsidiaries#show'

   post 'management/subsidiaries/update_leido', to: 'subsidiaries#update_leido'

   post 'management/subsidiaries/update_estado', to: 'subsidiaries#update_estado'

   post 'management/subsidiaries/update_credential', to: 'subsidiaries#update_credential'

   get 'people/obtener_cursos', to: 'people#obtener_cursos'

   get 'people/obtener_programaciones', to: 'people#obtener_programaciones'

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
