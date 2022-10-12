Rails.application.routes.draw do

  root :to => 'public#index'
  # get 'public/index'
  get 'show/:permalink', :to => 'public#show'
  # get 'public/show'

  # root route 
  # imp : spound sign is used to tell which is controller and which is action and not slash is used
  # root 'demo#index'
  # or
  # match "/", :to => "demo#index",  :via => :get

  # not using resourceful routes here as there's no model for this work and simple routes can work 
  get 'access/menu' #index
  get 'access/login' #new
  post 'access/attempt_login' #create
  get 'access/logout' #destroy
  # if the user is logged in then send to menu which will be controlled by the controller due to access control on the menu
  get 'admin', :to => 'access#menu'


  # following are by default added match routes, commented them to use resourceful routes.
  # get 'subjects/index'
  # get 'subjects/show'
  # get 'subjects/new'
  # get 'subjects/edit'
  # get 'subjects/delete'
  # get 'sections/index'
  # get 'sections/show'
  # get 'sections/new'
  # get 'sections/edit'
  # get 'sections/delete'
  # get 'pages/index'
  # get 'pages/show'
  # get 'pages/new'
  # get 'pages/edit'
  # get 'pages/delete'

  # get 'example/action1'
  # get 'example/action2'

  # resourceful routes
  resources :subjects do
    # adding a code block of `do` to get the 8th route of DELETE which is not be default adding by rails in the SubjectsController
    member do #member routes
      get :delete
    end
  end
  resources :pages do
    member do 
      get :delete
    end
  end
  resources :sections do
    member do 
      get :delete
    end
  end
  
  # get 'admin_users/index'
  # get 'admin_users/new'
  # get 'admin_users/edit'
  # get 'admin_users/delete'
  resources :admin_users, :except => [:show] do
    member do
      get :delete
    end
  end
  
  # match "example/action2", :to => "example#action1", :via => :get
  
  # simple match route
  get 'demo/index'
  # longer versioon 
  # match "demo/index", :to => "demo#index", :via => :get
  get 'demo/hello'
  get 'demo/other_hello'
  get 'demo/lynda'
  get 'demo/escape_output'

  # new default route : 
  # This will lead to a right match as the pattern in url will be compared like this and treated as controller/action accordingly.
  # But wont use it as it may go away in futuru rails versions.
  # get ':controller(/:action(/:id))'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
