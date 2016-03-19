class TopController < ApplicationController
  def index
    @restaurants = Restaurant.all.includes(:prefecture, :category)
  end
end
