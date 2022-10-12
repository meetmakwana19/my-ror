class PagesController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in
  before_action :find_subject
  
  # by default this controller filter will be applied to methods but putting an only option.
  before_action :find_subjects, :only => [:new, :create, :edit, :update]
  # so before these methods, the find_subjects instance variable be set for all those methods.

  before_action :set_page_coount, :only => [:new, :create, :edit, :update]

  def index
    #  @pages = Page.all
    # @pages = Page.sorted
    @pages = @subject.pages.sorted 
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new(:subject_id => @subject.id)
    # @page_count = Page.count + 1
    # @subjects = Subject.sorted
  end
  
  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "Page created succcessfully"
      redirect_to(pages_path(:subject_id => @subject.id))
    else
      # @page_count = Page.count + 1
      # @subjects = Subject.sorted
      render("new")
    end
  end

  def edit
    @page = Page.find(params[:id])
    # @page_count = Page.count 
    # @subjects = Subject.sorted
  end
  
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Page updated succcessfully"
      redirect_to(pages_path(@page, :subject_id => @subject.id))
    else
      # @page_count = Page.count 
      # @subjects = Subject.sorted
      render("edit")
    end
  end

  def delete
    @page = Page.find(params[:id])
  end
  
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Page '#{@page.name}' deleted succcessfully"
    redirect_to(pages_path(subject_id => @subject.id))
  end

  private
  def page_params
    params.require(:page).permit(:name, :subject_id, :permalink, :position, :visible)
  end

  def find_subject
    @subject = Subject.find(params[:subject_id])
  end

  def find_subjects
    @subjects = Subject.sorted
  end

  def set_page_coount 
    @page_count = Page.count
    if params[:action] == 'new' || params[:action] == 'create'
      @page_count += 1
    end
  end
  
end