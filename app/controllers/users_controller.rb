class UsersController < ApplicationController

  # rails will throw an error upon record creation if the ! operator is used
  # this method will rescue from that error and deliver the invalid object's 
  # error messsages as json
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  # create a new user 
  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    render json: user, status: :created
  end 

  # show 

  # render not found response if no record exists
  def show
    user = User.find_by(id: session[:user_id])
    if user
      render json: user
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end 
  end 

  # update user account, currently only username
  def update
    user = User.find_by(id: session[:user_id])
    user.update!(user_params)
    render json: user
  end 

  # add additional credits to user profile 
  def add_credits
    user = User.find_by(id: session[:user_id])
    credits = user.credits + user_params[:credits].to_i
    user.update!(credits: credits)
    render json: user
  end 

  private

  # permitted user params for login and account creation
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :image_url, :credits)
  end 

  # deliver invalid error message attribute as json in response body 
  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end 
end
