class TopController < ApplicationController
  def index
  @restaurants = Restaurant.all
  end
end
