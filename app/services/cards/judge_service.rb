class JudgeService
  include ActiveModel::Model

  VALID_CARD_REGEX =  /\A[SHDC]([1-9]|1[0-3]) [SHDC]([1-9]|1[0-3]) [SHDC]([1-9]|1[0-3]) [SHDC]([1-9]|1[0-3]) [SHDC]([1-9]|1[0-3])\z/
  POKER_HAND = [
    "High Card",
    "One Pair",
    "Two Pair",
    "Three of a Kind",
    "Straight",
    "Flush",
    "Full House",
    "Four of a Kind",
    "Straight Flush"
  ]

  attr_accessor :hand, :best
  attr_reader :cards, :card_suits, :card_numbers, :number_set, :flush, :straight, :poker_hand, :strength, :msg

  validate :check_valid_hand

  def check_valid_hand
    if @hand.blank?
      errors[:base] << "手札の情報が入力されていません。手札の情報を入力してください。（例：S8 S7 H6 H5 S4）"
      @msg = "手札の情報が入力されていません。手札の情報を入力してください。（例：S8 S7 H6 H5 S4）"
    elsif @hand.match(VALID_CARD_REGEX) == nil
      errors[:base] << "手札の情報が不正です。手札の情報を正確に入力してください。（例：S8 S7 H6 H5 S4）"
      @msg = "手札の情報が不正です。手札の情報を正確に入力してください。（例：S8 S7 H6 H5 S4）"
    else
      @msg = nil
    end
  end

  def judge_role
    split_hand
    count_same_number
    flush?
    straight?
    judge_hand
  end

  def judge_strength
    judge_role
    judge_score
  end

  class << self
    def judge_strongest(hands)
      judge_best(hands)
    end

    private
    def judge_best(hands)
      scores = []

      hands.each do |hand|
        scores.push hand.strength.to_i
      end

      high_score =  scores.max

      hands.each do |hand|
        if hand.strength == high_score
          hand.best = true
        else
          hand.best = false
        end
      end
    end
  end

  private
  def split_hand()
    @cards = @hand.split(" ")

    @card_suits = []
    @card_numbers = []

    @cards.each do |card|
      @card_suits.push card[0]
      @card_numbers.push card[1..-1].to_i
    end
  end

  def count_same_number()
    @number_set = @card_numbers.group_by{|number|number}.map{|key, value|value.size }.sort.reverse
  end

  def flush?()
    varieties = @card_suits.uniq.size
    if varieties == 1
      @flush = true
    else
      @flush = false
    end
  end

  def straight?()
    steps = @card_numbers.sort.map{|number|number - @card_numbers[0]}
    if steps == [-4,-3,-2,-1,0] || steps == [0,9,10,11,12]
      @straight = true
    else
      @straight = false
    end
  end

  def judge_hand()
    case [@straight, @flush]
    when [true, true]
      @poker_hand = POKER_HAND[8]
    when [false, true]
      @poker_hand = POKER_HAND[5]
    when [true, false]
      @poker_hand = POKER_HAND[4]
    else
      case @number_set
      when [4, 1]
        @poker_hand = POKER_HAND[7]
      when [3, 2]
        @poker_hand = POKER_HAND[6]
      when [3, 1, 1]
        @poker_hand = POKER_HAND[3]
      when [2, 2, 1]
        @poker_hand = POKER_HAND[2]
      when [2, 1, 1, 1]
        @poker_hand = POKER_HAND[1]
      else
        @poker_hand = POKER_HAND[0]
      end
    end
  end

  def judge_score()
    @strength = POKER_HAND.index(@poker_hand)
  end

end
