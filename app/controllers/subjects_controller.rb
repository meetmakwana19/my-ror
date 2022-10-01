class SubjectsController < ApplicationController

  layout "admin"
   
  def index
    # FInd subjects and assign them to instance variable so that the view template can access them
    # @subjects = Subject.all
    # will return all the subjects as an array and store it in the instance variable @subjects
    @subjects = Subject.sorted #using the scope created in the model subject.rb

    # no need to tell rails to render this template as it will do it automatically by looking at the method name 
    # render('index')
  end

  def show
    @subject = Subject.find(params[:id])
  end
  
  def new
    @subject = Subject.new({:name => "Default"})
    @subject_count = Subject.count + 1 #adding a new one now so +1
  end
  
  def create
    # • Instantiate a new object using form parameters
    @subject = Subject.new(subject_params)
    # • Save the object
    if @subject.save
      # • If save succeeds, redirect to the index action
      flash[:notice] = "Subject created succcessfully"
      redirect_to(subjects_path)
    else
      @subject_count = Subject.count + 1 #adding a new one now so +1
      # • If save fails, redisplay the form so user can fix problems
      render("new") #will render `new` view template and wont go to the def new method. Fields will be autofilled due to the paarams saved in the @subject object
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end
  
  def update
    # • Find the object using form parameters
    @subject = Subject.find(params[:id])
    # • Update the object
    # update_attributeswill need a hash of the new subject object so using params[:subject] to get that hash value. But update_attributes will mass assign the values which can be an issue
    # Therefore using the whitelisted values from subject_params
    # if @subject.update_attributes(params[:subject])
    if @subject.update_attributes(subject_params)
      # • If save succeeds, redirect to the show action
      flash[:notice] = "Subject updated succcessfully"
      redirect_to(subject_path(@subject))
    else
      @subject_count = Subject.count
      # • If save fails, redisplay the form so user can fix problems
      render("edit") #will render `edit` view template and wont go to the def edit method. Fields will be autofilled due to the paarams saved in the @subject object
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end
  
  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    flash[:notice] = "Subject '#{@subject.name} deleted succcessfully"
    redirect_to(subjects_path)
  end
  
  private
  def subject_params 
    params.require(:subject).permit(:name, :position, :visible)
  end

end
