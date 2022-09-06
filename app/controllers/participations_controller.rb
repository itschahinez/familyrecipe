class ParticipationsController < ApplicationController
  def destroy
    @circle = Circle.find(params[:circle_id])
    @participation = Participation.find_by(circle: @circle, user: current_user)
    @participation.destroy
    redirect_to root_path, status: :see_other
  end
end
