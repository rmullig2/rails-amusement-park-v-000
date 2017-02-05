class AttractionsController < ApplicationController
  def index
    @attractions = Attraction.all
    @user = User.find(session[:user_id])
  end

  def show
    #binding.pry
    @user = User.find(session[:user_id])
    @attraction = Attraction.find(params[:id])
  end
  
  def update
    #binding.pry
    @user = User.find(session[:user_id])
    @attraction = Attraction.find(params[:id])
    if !@user.admin?
      if @user.tickets >= @attraction.tickets && @user.height >= @attraction.min_height
        #binding.pry
        @user.tickets -= @attraction.tickets
        @user.nausea += @attraction.nausea_rating
        @user.happiness += @attraction.happiness_rating
        @user.save
        flash[:alert] = "Thanks for riding the #{@attraction.name}!"
      end
      if @user.height < @attraction.min_height 
        flash[:alert] = "You are not tall enough to ride the #{@attraction.name}"
      end
      if @user.tickets < @attraction.tickets
        flash[:error] = "You do not have enough tickets to ride the #{@attraction.name}"
      end
      redirect_to user_path(@user.id)
    else
      @attraction.update(attraction_params)
    end
  end

  def edit
    @attraction = Attraction.find(params[:id])
  end

  def delete
  end

  def new
    @attraction = Attraction.new
  end
  
  def create
    @attraction = Attraction.create(attraction_params)
    redirect_to attraction_path(@attraction.id)
  end
  
  private
  
  def attraction_params
    params.require(:attraction).permit(:name, :min_height, :happiness_rating, :nausea_rating, :tickets)
  end
end
