module SessionsHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    
    # this line is intended to create a current_user, which can be accessed by both the controller and the views
    #  this lets us do stuff like current_user.name and 'redirect_to current_user'
    current_user = user
  end
  
  #  the equals sign in the definition of this method means that it's expressedly designed for assignment to
  #   current_user
  def current_user=(user)
    @current_user = user
  end
  
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  
  def current_user
      @current_user ||= user_from_remember_token
    end

  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      cookies.signed[:remember_token] || [nil, nil]      
    end
    
    def signed_in?
      !current_user.nil?
    end
  
end
