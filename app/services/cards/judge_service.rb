class JudgeService
  include ActiveModel::Model

  VALID_CARD_REGEX =  /\A[SHDC]([1-9]|1[0-3]) [SHDC]([1-9]|1[0-3]) [SHDC]([1-9]|1[0-3]) [SHDC]([1-9]|1[0-3]) [SHDC]([1-9]|1[0-3])\z/
  POKER_HAND = ["High Card", "One Pair", "Two Pair", "Three of a Kind",
                "Straight", "Flush", "Full House", "Four of a Kind", "Straight Flush"]

  attr_accessor :card_set, :best
  attr_reader :cards, :suits, :numbers, :number_set, :flush, :straight, :hand, :strength, :msg

  validate :check_valid_card_set

  def check_valid_card_set
    if @card_set.blank?
      @msg = "手札の情報が入力されていません。手札の情報を入力してください。（例：S8 S7 H6 H5 S4）"
    elsif @card_set.match(VALID_CARD_REGEX) == nil
      @msg = "手札の情報が不正です。手札の情報を正確に入力してください。（例：S8 S7 H6 H5 S4）"
    else
      @msg = nil
    end
  end

  def judge_hand
    split_card_set
    count_same_number
    flush?
    straight?
    judge_role
  end

  def judge_strength
    judge_hand
    judge_score
  end

  class << self
    def judge_strongest(cards)
      judge_best(cards)
    end

    private
    def judge_best(cards)
      scores = []

      cards.each do |card|
        scores.push card.strength.to_i
      end

      high_score =  scores.max

      for i in 0..cards.length-1 do
        if cards[i].strength == high_score
          cards[i].best = true
        else
          cards[i].best = false
        end
      end
    end
  end

  private
  def split_card_set()
    @cards = @card_set.split(" ")

    @suits = []
    @numbers = []

    @cards.each do |card|
      @suits.push card[0]
      @numbers.push card[1..-1].to_i
    end
  end

  def count_same_number()
    @number_set = @numbers.group_by{|number|number}.map{|key, value|value.size }.sort.reverse
  end

  def flush?()
    variety = @suits.uniq.size
    if variety == 1
      @flush = true
    else
      @flush = false
    end
  end

  def straight?()
    steps = @numbers.sort.map{|number|number - @numbers[0]}
    if steps == [-4,-3,-2,-1,0] || steps == [0,9,10,11,12]
      @straight = true
    else
      @straight = false
    end
  end

  def judge_role()
    case [@straight, @flush]
    when [true, true]
      @hand = POKER_HAND[8]
    when [false, true]
      @hand = POKER_HAND[5]
    when [true, false]
      @hand = POKER_HAND[4]
    else
      case @number_set
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

  def judge_score()
    @strength = POKER_HAND.index(@hand)
  end

end
