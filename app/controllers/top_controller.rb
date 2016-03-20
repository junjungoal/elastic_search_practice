class TopController < ApplicationController
  def index
    @restaurants = Restaurant.search(params[:query])
  end
end
