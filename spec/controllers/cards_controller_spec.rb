require 'rails_helper'

describe CardsController do

  describe 'Get #top' do
    let(:judge_service){build(:card)}
    before do
      get :top
    end
    it 'リクエストは200 OKとなること' do
      expect(response.status).to eq 200
    end
    it '@cardに新しい手札を割り当てること' do
      expect(assigns(:card)).not_to be_nil
    end
    it ':topテンプレートを表示すること' do
      expect(response).to render_template :top
    end
  end

  describe 'Post #check' do
    let(:judge_service){attributes_for(:card)}
    context '有効なパラメータの場合' do
      before do
        card_set = 'C7 C6 C5 C4 C3'
        post :check, params: { judge_service: { card_set: card_set } }
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it ':resultテンプレートを表示すること' do
        expect(response).to render_template :result
      end
    end

    let(:judge_service){attributes_for(:invalid_card)}
    context '無効なパラメータの場合' do
      before do
        card_set = ''
        post :check, params: { judge_service: { card_set: card_set } }
      end
      it 'リクエストは200 OKとなること' do
        expect(response.status).to eq 200
      end
      it ':errorテンプレートを表示すること' do
        expect(response).to render_template :error
      end
    end
  end
end
