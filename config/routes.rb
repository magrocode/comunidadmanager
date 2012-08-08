Comunidadmanager::Application.routes.draw do
 
  filter :locale
 

    get "paginas/home"
    get "paginas/wellcome"
    get "paginas/comunidad_desactivada"

    resources :usuarios do
      member do
        get :unidades_autorizadas
        get :permisos
      end
    end

    resources :unidads do
      member do
        get :vinculadas
        get :usuarios_autorizados
      end
    end
    resources :tipounidads, only: [:index, :new, :edit, :create, :destroy, :update] 
    resources :posts, only: [:create, :destroy, :edit, :update]
  
    resources :comunidads do
      member do
        put :desactivar
        put :activar
        put :seleccionar
      end
        
      resources :unidads
      resources :tipounidads
      resources :usuarios
      resources :posts
    end

    resources :sessions,                  only: [:new, :create, :destroy]
    resources :relacion_comunidad_usuarios,  only: [:create, :destroy, :update]
    resources :relacion_unidads,          only: [:create, :destroy]
    resources :relacion_usuario_unidads,  only: [:create, :destroy]

    match '/wellcome', to: 'paginas#wellcome'
    match '/comunidad_desactivada', to: 'paginas#comunidad_desactivada'
    match '/signup', to: 'comunidads#new'
    match '/signin', to: 'sessions#new'
    match '/signout', to: 'sessions#destroy', via: :delete
  #match '/:locale' => 'dashboard#index'
  
  #match '/:locale' => 'paginas#home'
  root :to => 'paginas#home'


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
