class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @disable_navbar = true
  end

  def visio
    @circle = Circle.find(params[:circle_id])
  end
end
