FactoryBot.define do
  factory :card, class: JudgeService do
    card_set { 'C7 C6 C5 C4 C3' }
  end

  factory :invalid_card, class: JudgeService do
    card_set { '' }
  end
end
