class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
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
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
