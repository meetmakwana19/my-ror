Rails.application.routes.draw do
  get 'example/action1'
  get 'example/action2'
  # match "example/action2", :to => "example#action1", :via => :get
  
  # simple match route
  get 'demo/index'
  # longer versioon 
  # match "demo/index", :to => "demo#index", :via => :get
  get 'demo/hello'
  get 'demo/other_hello'
  get 'demo/lynda'

  # new default route : 
  # This will lead to a right match as the pattern in url will be compared like this and treated as controller/action accordingly.
  # But wont use it as it may go away in futuru rails versions.
  # get ':controller(/:action(/:id))'


  # root route 
  # imp : pound sign is used to tell which is controller and which is action and not slash is used
  # root 'demo#index'
  # or
  # match "/", :to => "demo#index",  :via => :get
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
