class ApplicationController < ActionController::Base
    # for preventing CSRF
    protect_from_forgery with: :exception
    # exception is another word for error in ruby
end
