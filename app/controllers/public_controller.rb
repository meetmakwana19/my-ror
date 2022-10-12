class PublicController < ApplicationController

  layout 'public'

  before_action :setup_navigation 

  def index
    # intro text
  end

  def show
    # a page to show 
    @page = Page.visible.where(:permalink => params[:permalink]).first
    if @page.nil?
      redirect_to(root_path) # a helper for routing to root route
    else
      # display page content using show.html.erb
    end
  end

  private

  def setup_navigation
    # all pages will have subjects available
    @subjects = Subject.visible.sorted
  end
end
