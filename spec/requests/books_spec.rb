require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "Books", type: :request do
  let(:headers) {{ 'Accept' => 'application/json', 'Content-Type' => 'application/json' }}
  let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers(headers, create(:user, :librarian)) }

  describe "index" do
    before { FactoryBot.create_list(:book, 11) }

    it "returns http_success and paginated list of books" do
      get "/books", headers: auth_headers

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body).count).to eq(10)
      expect(Book.pluck(:id)).to include(*JSON.parse(response.body).map {|item| item["id"]})
    end
  end

  describe "create" do
    subject do
      post "/books",
           params: params,
           as: :json,
           headers: auth_headers
    end

    describe "valid attributes" do
      let(:params) do
        {
          title: "Test 1",
          description: "Teste"
        }
      end

      it { expect{ subject }.to change(Book, :count).by(1) }

      it "returns status created" do
        subject

        expect(response.status).to eq(201)
      end
    end

    describe "invalid attributes" do
      let(:params) do
        {
          title: nil,
          description: nil
        }
      end

      it { expect{ subject }.to change(Book, :count).by(0) }

      it "returns status unprocessable_entity" do
        subject

        expect(response.status).to eq(422)
      end
    end
  end

  describe "update" do
    let(:book) { create(:book) }

    subject do
      patch "/books/#{book.id}",
           params: params,
           as: :json,
           headers: auth_headers
    end

    describe "valid attributes" do
      let(:params) do
        {
          title: "Test 1",
          description: "Teste"
        }
      end

      let(:old_title) { book.title }
      let(:old_description) { book.description }

      it { expect{ subject }.to change { book.reload.title }.from(old_title).to(params[:title]) }
      it { expect{ subject }.to change { book.reload.description }.from(old_description).to(params[:description]) }

      it "returns status ok" do
        subject

        expect(response.status).to eq(200)
      end
    end

    describe "invalid attributes" do
      let(:params) do
        {
          title: nil,
          description: nil
        }
      end

      it { expect{ subject }.to_not change { book.reload.title } }
      it { expect{ subject }.to_not change { book.reload.description } }

      it "returns status unprocessable_entity" do
        subject

        expect(response.status).to eq(422)
      end
    end
  end

  describe "destroy" do
    let!(:book) { create(:book) }

    subject do
      delete "/books/#{book.id}", headers: auth_headers
    end
    
    describe "success path" do
      it { expect{ subject }.to change { Book.count }.from(1).to(0) }

      it "returns status ok" do
        subject

        expect(response.status).to eq(204)
      end
    end
  end
end
