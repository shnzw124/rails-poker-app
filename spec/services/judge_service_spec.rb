require 'rails_helper'

describe JudgeService do

  describe 'check_valid_card' do
    context 'S,H,D,Cと1..13からなるカード5枚で手札が構成されている場合' do
      it '手札が有効であること' do
        card = JudgeService.new(card_set: 'C7 C6 C5 C4 C3')
        expect(card).to be_valid
      end
    end
    context 'S,H,D,Cと1..13からなるカード6枚以上で手札が構成されている場合' do
      it '手札が無効であること' do
        card = JudgeService.new(card_set: 'C7 C6 C5 C4 C3 C2')
        expect(card).not_to be_valid
      end
    end
    context 'S,H,D,Cと1..13からなるカード1枚以上4枚以下で手札が構成されている場合' do
      it '手札が無効であること' do
        card = JudgeService.new(card_set: 'C7 C6 C5 C4')
        expect(card).not_to be_valid
      end
    end
    context '手札にカードが一枚も存在しない場合' do
      it '手札が無効であること' do
        card = JudgeService.new(card_set: "")
        expect(card).not_to be_valid
      end
    end
    context '手札を仕切るスペースが連続している場合' do
      it '手札が無効であること' do
        card = JudgeService.new(card_set: 'C7  C6 C5 C4 C3')
        expect(card).not_to be_valid
      end
    end
    context '手札がスペース以外で仕切られている場合' do
      it '手札が無効であること' do
        card = JudgeService.new(card_set: 'C7,C6,C5,C4,C3')
        expect(card).not_to be_valid
      end
    end
    context 'S,H,D,C以外と1..13からなるカードで手札が構成されている場合' do
      it '手札が無効であること' do
        card = JudgeService.new(card_set: 'A7 C6 C5 C4 C3')
        expect(card).not_to be_valid
      end
    end
    context 'S,H,D,Cと1..13以外からなるカードで手札が構成されている場合' do
      it '手札が無効であること' do
        card = JudgeService.new(card_set: 'C14 C6 C5 C4 C3')
        expect(card).not_to be_valid
      end
    end
  end

  describe 'judge' do
    context '手札の役がストレートフラッシュである場合' do
      it '"Straight Flush"を返すこと' do
        card = JudgeService.new(card_set: 'C7 C6 C5 C4 C3')
        expect(card.judge_role).to eq "Straight Flush"
      end
    end
    context '手札の役がフラッシュである場合' do
      it '"Flush"を返すこと' do
        card = JudgeService.new(card_set: 'H1 H12 H10 H5 H3')
        expect(card.judge_role).to eq "Flush"
      end
    end
    context '手札の役がストレートである場合' do
      it '"Straight"を返すこと' do
        card = JudgeService.new(card_set: 'S1 H13 D12 C11 H10')
        expect(card.judge_role).to eq "Straight"
      end
    end
    context '手札の役がフォー・オブ・ア・カインドである場合' do
      it '"Four of a Kind"を返すこと' do
        card = JudgeService.new(card_set: 'C10 D10 H10 S10 D5')
        expect(card.judge_role).to eq "Four of a Kind"
      end
      context '手札の役がフルハウスである場合' do
        it '"Full House"を返すこと' do
          card = JudgeService.new(card_set: 'S10 H10 D10 S4 D4')
          expect(card.judge_role).to eq "Full House"
        end
      end
      context '手札の役がスリー・オブ・ア・カインドである場合' do
        it '"Three of a Kind"を返すこと' do
          card = JudgeService.new(card_set: 'S12 C12 D12 S5 C3')
          expect(card.judge_role).to eq "Three of a Kind"
        end
      end
      context '手札の役がツーペアである場合' do
        it '"Two Pair"を返すこと' do
          card = JudgeService.new(card_set: 'H13 D13 C2 D2 H11')
          expect(card.judge_role).to eq "Two Pair"
        end
      end
      context '手札の役がワンペアである場合' do
        it '"One Pair"を返すこと' do
          card = JudgeService.new(card_set: 'C10 S10 S6 H4 H2')
          expect(card.judge_role).to eq "One Pair"
        end
      end
      context '手札の役がハイカードである場合' do
        it '"High Card"を返すこと' do
          card = JudgeService.new(card_set: 'D1 D10 S9 C5 C4')
          expect(card.judge_role).to eq "High Card"
        end
      end
    end
  end

end
