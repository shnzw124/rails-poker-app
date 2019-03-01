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

end
