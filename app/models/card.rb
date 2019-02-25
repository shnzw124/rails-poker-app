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

  def straight?
    steps = @number.sort.map{|number|number - @number[0]}
    if steps == [-4,-3,-2,-1,0] || steps == [0,9,10,11,12]
      @straight = true
    else
      @straight = false
    end
  end

  def judge_hand
    case [@straight, @flush]
    when [true, true]
      @hand = POKER_HAND[8]
    when [false, true]
      @hand = POKER_HAND[5]
    when [true, false]
      @hand = POKER_HAND[4]
    else
      case @number_of_sets
      when [4, 1]
        @hand = POKER_HAND[7]
      when [3, 2]
        @hand = POKER_HAND[6]
      when [3, 1, 1]
        @hand = POKER_HAND[3]
      when [2, 2, 1]
        @hand = POKER_HAND[2]
      when [2, 1, 1, 1]
        @hand = POKER_HAND[1]
      else
        @hand = POKER_HAND[0]
      end
    end
  end

  def judge_strength
    @strength = POKER_HAND.index(@hand)
  end
end
