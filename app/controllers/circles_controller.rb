class CirclesController < ApplicationController
  def index
    @circles = current_user.circles
  end

  def show
    @circle = Circle.find(params[:id])
    @participation = @circle.participations.build
    @other_users = User.all - @circle.users
    @circle_recipe = CircleRecipe.new
  end

  def new
    @circle = Circle.new
    @users = @circle.participations.build
    @other_users = User.other_users(current_user)
  end

  def create
    @circle = Circle.new(circle_params)
    if @circle.save
      @user_participation = Participation.create(user: current_user, circle: @circle)
      redirect_to circle_path(@circle)
    else
      render "circles/new", status: :unprocessable_entity
    end
  end

  def update
    @circle = Circle.find(params[:id])
    if @circle.update(circle_params)
      redirect_to @circle
    else
      render @circle
    end
  end

  private

  def circle_params
    params.require(:circle).permit(:name, participations_attributes: [:id, :user_id, :first_name, :_destroy])
  end
end
