Fed::Application.routes.draw do

  #users
  get 'users/:remember_token' => 'users#index'
  get 'users/:id/:remember_token' => 'users#show'
  delete 'users/:id/:remember_token' => 'users#destroy'

  #food_entries
  get 'users/:user_id/food_entries/:page/:count/:remember_token' => 'food_entries#index'
  get 'users/:user_id/food_entries/:id/:remember_token' => 'food_entries#show'
  delete 'users/:user_id/food_entries/:id/:remember_token' => 'food_entries#destroy'
  
  #event_entries
  get 'users/:user_id/event_entries/:remember_token' => 'event_entries#index'
  get 'users/:user_id/event_entries/:id/:remember_token' => 'event_entries#show'
  delete 'users/:user_id/event_entries/:id/:remember_token' => 'event_entries#destroy'


  resources :users do
    resources :event_entries
    resources :food_entries
  end


  #With remember_token
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
