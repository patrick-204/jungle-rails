class SessionsController < ApplicationController

  def new
  end

  def create
    # Authenticate the user using the class method
    user = User.authenticate_with_credentials(params[:email], params[:password])

    if user
      # Save the user id inside the browser cookie to keep them logged in
      session[:user_id] = user.id
      redirect_to root_path
    else
      # If login fails, render the login form again with an error message
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
