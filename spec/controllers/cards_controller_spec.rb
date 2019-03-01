require 'rails_helper'

describe CardsController do

  describe 'Get #top' do
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
    let(:judge_service) { JudgeService.new() }
    context '有効なパラメータの場合' do
      it 'リクエストは200 OKとなること' do
        card_set = 'C7 C6 C5 C4 C3'
        post :check, params: { judge_service: { card_set: card_set } }
        expect(response.status).to eq 200
      end
      it ':resultテンプレートを表示すること' do
        card_set = 'C7 C6 C5 C4 C3'
        post :check, params: { judge_service: { card_set: card_set } }
        expect(response).to render_template :result
      end
    end
    context '無効なパラメータの場合' do
      it 'リクエストは200 OKとなること' do
        card_set = ''
        post :check, params: { judge_service: { card_set: card_set } }
        expect(response.status).to eq 200
      end
      it ':errorテンプレートを表示すること' do
        card_set = ''
        post :check, params: { judge_service: { card_set: card_set } }
        expect(response).to render_template :error
      end
    end
  end
end
