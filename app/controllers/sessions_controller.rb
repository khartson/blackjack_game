class SessionsController < ApplicationController

  # create session via login
  # if a user attempts login, fetch username and password from request params
  # authenitcate user and either return user info as json or unauthorized response
  # add the user to the session cookie if exists and auth'd
  def create
    user = User.find_by(username: [params[:username]])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      return render json: user, status: :created
    else
      render json: { errors: ['Invalid username or password'] }, status: :unauthorized
    end 
  end 

  # session destroy / logout 
  # deletes user data from session cookie and returns either no content resposne 
  # or unauthorized if attempting to log out when not logged in
  def destroy 
    if session[:user_id]
      session.delete :user_id
      head :no_content
    else 
      render json: { errors: ['You are not logged in'] }, status: :unauthorized
    end 
  end 

end
