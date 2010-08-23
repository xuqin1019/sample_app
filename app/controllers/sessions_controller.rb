class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end
  
  def create
    #calls on our authenticate method
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      # doesn't display this message, but rather saves it to the flash, which then is automatically displayed
      # by the main application view.  We can't use the "validates" methods in the user model because this isn't
      # an Active Record model.  So instead we use the flash.
      flash.now[:error] = "Invalid email/password combination."
      
      # @title is also accessed by the application view
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      redirect_to user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end


end
