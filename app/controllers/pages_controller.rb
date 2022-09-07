class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @disable_navbar = true
    @events = Event.all.order(created_at: :desc).limit(5)
  end

  def visio
    @circle = Circle.find(params[:circle_id])
  end
end
