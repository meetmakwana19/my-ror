class DemoController < ApplicationController #this is a ruby class inherited from ApplicationController

  layout false 
  
  def index #this is a ruby method, also called as an ACTION which renders a view
    # by default if nothing is specified in index method then rails tells it to use index template i.e. app/views/demo/index.html.erb

    # explicit render commands to render index template
    render('demo/index')
    # render('index')

    # other writing conventions
    # render(:template => 'demo/hello') #*hello is used in index 
  end

  def hello
    # render('index') #if this is used then at /hello endpoint, index template will be explicitly rendered
    render('hello')

  end
end
