class Api::PredictionsController < ApplicationController
  def show
    if not params.key?(:teams)
      return render json: '"Please provide teams as a query parameters"', status: 400
    elsif params[:teams].is_a?(Array) == false or params[:teams].size != 2
      return render json: '"Please provide two teams to get the winning probability"', status: 400
    end
    teams = params[:teams]
    render json: TeamPrediction.new.winning_probability_of(teams.first, teams.second)
  end
end