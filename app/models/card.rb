class Card < ApplicationRecord
  POKER_HAND = ["High Card", "One Pair", "Two Pair", "Three of a Kind",
                "Straight", "Flush", "Full House", "Four of a Kind", "Straight Flush"]
  attr_accessor :cards, :card, :suit, :number, :number_of_sets, :flush, :straight, :hand, :strength

  def split_cards
    @card = @cards.split(" ")
  end

  def split_card_into_suit
    @suit = []
    @card.each do |card|
      @suit.push card[0]
    end
  end

  def split_card_into_number
    @number = []
    @card.each do |card|
      @number.push card[1..-1].to_i
    end
  end
end
