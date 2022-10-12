class PublicController < ApplicationController
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
end
