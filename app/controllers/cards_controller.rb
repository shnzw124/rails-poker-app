class CardsController < ApplicationController
  def top
    @card = JudgeService.new
  end

  def result
  end

  def error
  end

  def check
    @card = JudgeService.new(card_params)
    if @card.valid?
      @card.judge
      render :result
    else
      render :error
    end
  end

  private
  def card_params
    params.require(:judge_service).permit(:card_set)
  end
end
