class CardsController < ApplicationController

  def top
    @hand = JudgeService.new
  end

  def result
  end

  def error
  end

  def check
    @hand = JudgeService.new(hand_params)
    if @hand.valid?
      @hand.judge_role
      render :result, :status => 200
    else
      render :error
    end
  end

  private
  def hand_params
    params.require(:judge_service).permit(:hand)
  end
end
