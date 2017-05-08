class HealthchecksController < ApplicationController
  def show
    render json: '"ok"'
  end
end