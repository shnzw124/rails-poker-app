class CardsController < ApplicationController
  def top
    @cards = Card.new
  end

  def result
  end

  def error
  end

  def check
    @cards = Card.new(card_params)
    if @cards.save
      @cards.split_cards
      @cards.split_card_into_suit
      @cards.split_card_into_number
      @cards.count_same_number
      @cards.flush?
      @cards.straight?
      @cards.judge_hand
      render :result
    else
      render :error
    end
  end

  private
  def card_params
    params.require(:card).permit(:cards)
  end
end
