require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "Books", type: :request do
  let(:user_auth) { create(:user, :librarian) }
  let(:headers) {{ 'Accept' => 'application/json', 'Content-Type' => 'application/json' }}
  let!(:auth_headers) { Devise::JWT::TestHelpers.auth_headers(headers, user_auth) }

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
          description: "Teste",
          picture_attributes: {url: "https://teste.com"},
          authors_attributes: [{name: "Teste"}]
        }
      end

      it { expect{ subject }.to change(Book, :count).by(1) }
      it { expect{ subject }.to change(Picture, :count).by(1) }
      it { expect{ subject }.to change(Author, :count).by(1) }

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
    let!(:book) { create(:book) }
    let!(:picture) { create(:picture, imageable_type: book.class, imageable_id: book.id) }
    let!(:author) { create(:author, books: [book]) }
    let!(:user) { create(:user, favorite_books: [book]) }

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
          description: "Teste",
          picture_attributes: {id: picture.id, url: "https://teste.com"},
          authors_attributes: [{id: author.id, name: "Teste"}],
          users_who_favorited_attributes: [{id: user.id, _destroy: 1}]
        }
      end

      let(:old_title) { book.title }
      let(:old_description) { book.description }
      let(:old_picture_url) { picture.url }
      let(:old_author_name) { author.name }

      it { expect{ subject }.to change { book.reload.title }.from(old_title).to(params[:title]) }
      it { expect{ subject }.to change { book.reload.description }.from(old_description).to(params[:description]) }
      it { expect{ subject }.to change { book.reload.picture.url }.from(old_picture_url).to(params[:picture_attributes][:url]) }
      it { expect{ subject }.to change { book.reload.authors.first.name }.from(old_author_name).to(params[:authors_attributes].first[:name]) }
      it { expect{ subject }.to change { book.reload.users_who_favorited.count }.by(-1) }

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

  describe "favorite" do
    let!(:book) { create(:book) }
    let(:user_auth) { create(:user, :reader) }

    subject do
      patch "/books/#{book.id}/favorite", headers: auth_headers
    end

    it "book users_who_favorites must contain auth_user" do
      expect{ subject }.to change { book.reload.users_who_favorited.count }.from(0).to(1) 
      expect(book.reload.users_who_favorited.first).to eq(user_auth)
    end

    it "returns status ok" do
      subject

      expect(response.status).to eq(204)
    end
  end
end
