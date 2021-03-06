class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(name: params[:user][:name]).try(:authenticate, params[:user][:password])
    session[:user_id] = @user.id
    redirect_to user_path(@user)
    #binding.pry
  end
  
  def destroy
    session.delete :user_id
    redirect_to root_path
  end
end
