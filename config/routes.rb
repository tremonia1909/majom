Rails.application.routes.draw do


  #devise_for :users
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :projects, :packets, :comments, :contacts
  resources :project, :packet, :comment,  :user, :user_packet, :user_project,:userpacket, :userproject, :role
  resources :home
 # resources :pages

  #Kalender-Events
  resources :events

  #Landing
  get '/landing', to: 'home#landing'
  get '/', to: 'home#landing'
  get 'impressum', to: 'home#impressum'

  #Projekt
  get 'create_project', to: 'projects#new'
  post "create_project", to: 'projects#create'
  get "addMember", to: 'projects#showMember'
  post 'addMember', to: 'projects#addMember'
  get 'overview', to: 'projects#overview'
  post 'overview', to: 'projects#update'

  #Packet
  get 'create_packet', to: 'packets#new'
  get 'dashboard', to: 'packets#dashboard'
  post 'create_packet', to: 'packets#create'
  get "/packets", to:  'packets#new'
  post 'dashboard', to: 'packets#update'

  #Kontakte
  get 'contacts', to: 'contacts#contacts'
  get 'show', to: 'contacts#show'
  get 'profile', to: 'contacts#profile'

  #Kommentare
  get '/comments', to: 'comments#new'
  post 'comments', to: 'comments#create'

  #Kalender
  get '/pages/calendar', to: 'events#calendar'
  get 'calendar' ,to: 'events#calendar'

  #Termin-Übersicht
  get 'pages/events' ,to: 'events#index'
  get 'events', to: 'events#index'
  patch 'events' , to: 'events#update'


  #Startseite
  get 'pages/index' => 'high_voltage/pages#show', id: 'index'

  # See how all your routes lay out with "rake routes".
  # The priority is based upon order of creation: first created -> highest priority.

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
