class SubjectsController < ApplicationController
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
  end

  def create
    # • Instantiate a new object using form parameters
    @subject = Subject.new(subject_params)
    # • Save the object
    if @subject.save
      # • If save succeeds, redirect to the index action
      redirect_to(subjects_path)
    else
      # • If save fails, redisplay the form so user can fix problems
      render("new") #will go to the `def new` with the already created @subject in this method so that the fields are auto-filled
    end
  end

  def edit
    @subject = Subject.find(params[:id])
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
      redirect_to(subject_path(@subject))
    else
      # • If save fails, redisplay the form so user can fix problems
      render("edit") #will go to the `def edit` with the already created @subject in this method so that the fields are auto-filled
    end
  end

  def delete
  end

  def destroy
  end
  
  private
  def subject_params 
    params.require(:subject).permit(:name, :position, :visible)
  end

end
