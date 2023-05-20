class WitchCalculatorController < ApplicationController
  def index; end

  def calculate_average_kills
    calculator = WitchCalculatorService.new(params[:persons])
    redirect_to witch_calculator_result_path(average_kills: calculator.calculate_average_kills)
  end

  def result
    @average_kills = params[:average_kills]
  end
end
