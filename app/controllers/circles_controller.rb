class CirclesController < ApplicationController
  def index
    @circles = current_user.circles
  end

  def show
    @circle = Circle.find(params[:id])
  end

  def new
    @circle = Circle.new
    @participation = @circle.participations.build
    @other_users = User.other_users(current_user)
  end

  def create
    @circle = Circle.new(circle_params)
    if @circle.save
      raise
      redirect_to circle_path(@circle)
    else
      render "circles/new", status: :unprocessable_entity
    end
  end

  def update
  end

  private

  def circle_params
    params.require(:circle).permit(:name, participations_attributes: [:id, :user_id, :first_name, :_destroy])
  end
end
