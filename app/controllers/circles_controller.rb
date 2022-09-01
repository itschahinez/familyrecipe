class CirclesController < ApplicationController
  def index
    @circles = current_user.circles
  end

  def show
  end

  def new
  end

  def create
  end

  def update
  end
end
