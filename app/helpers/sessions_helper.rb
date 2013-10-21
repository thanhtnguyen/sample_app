module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token #create new token
    cookies.permanent[:remember_token] = remember_token #place the unencrypted token in the browser cookies
    user.update_attribute(:remember_token, User.encrypt(remember_token)) #save the encrypted token to the database
    self.current_user = user #set the current user equal to the given user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    #assigning to a variable if it’s nil but otherwise leaving it alone
    @current_user ||= User.find_by(remember_token: remember_token) #equal to: @current_user = @current_user || User.find_by(remember_token: remember_token)
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
end
