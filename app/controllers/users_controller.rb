class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy] #need authenticate when doing "edit" and "update" action
  before_action :correct_user,   only: [:edit, :update] #user can only edit his own information
  before_action :admin_user,     only: :destroy
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def index
    #@users = User.all
    @users = User.paginate(page: params[:page])
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  
  # adding resources :users to the routes.rb file ensures that a POST request to /users is handled by the create action
  def create
    @user = User.new(user_params)
    #@user = User.new(params[:user]) #don't use this because of security risk
    if @user.save
      sign_in @user #sign in right after sign up
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user  
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @user.update_attributes(user_params) #the use of user_params in the call to update_attributes, which uses strong parameters to prevent mass assignment vulnerability
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end  
  end
  
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    
    # Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end    
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
