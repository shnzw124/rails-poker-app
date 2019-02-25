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

  def count_same_number
    @number_of_sets = @number.group_by{|number|number}.map{|key, value|value.size }.sort.reverse
  end

  def flush?
    variety = @suit.uniq.size
    if variety == 1
      @flush = true
    else
      @flush = false
    end
  end
end
