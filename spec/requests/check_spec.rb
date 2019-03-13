require 'rails_helper'

RSpec.describe "Check", type: :request do
  describe "POST /api/vi/cards/check" do
    context '有効なパラメータの場合' do
      before do
        cards = {"cards": ["C7 C6 C5 C4 C3", "D1 D10 S9 C5 C4"]}
        post '/api/v1/cards/check', params: cards
      end

      it 'リクエストは201 Createdとなること' do
        expect(response.status).to eq 201
      end

      it '期待する役および最も強い手札が判定されていること' do
        json_body = JSON.parse(response.body)
        expect(json_body["result"][0]["card_set"]).to eq 'C7 C6 C5 C4 C3'
        expect(json_body["result"][0]["hand"]).to eq 'Straight Flush'
        expect(json_body["result"][0]["best"]).to eq true
        expect(json_body["result"][1]["card_set"]).to eq 'D1 D10 S9 C5 C4'
        expect(json_body["result"][1]["hand"]).to eq 'High Card'
        expect(json_body["result"][1]["best"]).to eq false
      end

    end

    context '無効なパラメータの場合' do
      before do
        invalid_cards = {"cards": ["C7 C6 C5 C4 C3 C2", ""]}
        post '/api/v1/cards/check', params: invalid_cards
      end

      it 'リクエストは201 Createdとなること' do
        expect(response.status).to eq 201
      end

      it '期待するエラーメッセージが格納されていること' do
        json_body = JSON.parse(response.body)
        expect(json_body["error"][0]["card_set"]).to eq 'C7 C6 C5 C4 C3 C2'
        expect(json_body["error"][0]["msg"]).to eq '手札の情報が不正です。手札の情報を正確に入力してください。（例：S8 S7 H6 H5 S4）'
        expect(json_body["error"][1]["card_set"]).to eq ''
        expect(json_body["error"][1]["msg"]).to eq '手札の情報が入力されていません。手札の情報を入力してください。（例：S8 S7 H6 H5 S4）'
      end

    end

    context '不正なURLの場合' do
      before do
        cards = {"cards": ["C7 C6 C5 C4 C3", "D1 D10 S9 C5 C4"]}
        post '/api/v1/check', params: cards
      end

      it 'リクエストは404 Not Foundとなること' do
        expect(response.status).to eq 404
      end

      it '期待するエラーメッセージが格納されていること' do
        json_body = JSON.parse(response.body)
        expect(json_body["error"]).to eq '404 Not Found：指定されたURLは存在しません'
      end

    end

  end
end
