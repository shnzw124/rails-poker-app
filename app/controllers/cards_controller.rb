class CardsController < ApplicationController
  def top
    @card = Card.new
  end

  def result
  end

  def error
  end

  def check
    @card = Card.new(card_params)
    if @card
      @service = JudgeService.new(card_params)
      if @service.valid?
        @service.judge
        render :result
      else
        render :error
      end
    else
      render :error
    end
  end

  private
  def card_params
    params.require(:card).permit(:card_set)
  end
end
