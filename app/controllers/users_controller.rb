class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end
  
  def show
    #binding.pry
    if session[:user_id].nil?
      redirect_to root_path
    else
      @user = User.find(params[:id])
    end
  end
  
  def signin
    @user = User.new
    #binding.pry
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :password, :height, :happiness, :nausea, :tickets, :admin)
  end
end
