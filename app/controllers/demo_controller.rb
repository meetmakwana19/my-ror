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
    
    # instance variable, always starting with @
    @array = [1,2,3,4,5]
    
    # setting params as instance variable in controller will give us access to them in the template 
    @id = params['id'] #string param 
    @page = params[:page] #symbol param
    
    # render('index') #if this is used then at /hello endpoint, index template will be explicitly rendered
    # Learnt* : ALways render template at the end of action of method and after all the instance variables are defined.
    render('hello')
    
  end

  def other_hello
    # redirect_to(:controller => 'demo', :action => 'index')
    redirect_to( :action => 'index')
  end

  def lynda 
    redirect_to("https://lynda.com")
  end

end
