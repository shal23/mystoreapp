class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
   # @users = User.all
    @users = User.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url,
          notice: "User #{@user.name} was successfully created." }
        format.json { render json: @user,
          status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors,
          status: :unprocessable_entity }
    end
  end
end
  
  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'

    @user = User.find(params[:id])

    respond_to do |format|
    if @user.update_attributes(params[:user])
   # if @user.update_attributes(params[:user], :as => :admin)
      format.html { redirect_to users_url,
         notice: "User #{@user.name} was successfully updated." }
      format.json { head :no_content }
     # redirect_to users_path, :notice => "User updated."
    else
     # redirect_to users_path, :alert => "Unable to update user."
      format.html { render action: "edit" }
      format.json { render json: @user.errors,
          status: :unprocessable_entity }
    end
  end
end
    
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
end