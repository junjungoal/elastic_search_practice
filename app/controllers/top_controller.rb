class TopController < ApplicationController
  def index
   # @restaurants = Restaurant.search(params[:query])
  @restaurants = Restaurant.all
  end
end
