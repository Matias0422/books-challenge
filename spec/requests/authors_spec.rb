require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "Authors", type: :request do
  let(:headers) {{ 'Accept' => 'application/json', 'Content-Type' => 'application/json' }}
  let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers(headers, create(:user, :librarian)) }

  describe "index" do
    before { FactoryBot.create_list(:author, 11) }

    it "returns http_success and paginated list of authors" do
      get "/authors", headers: auth_headers

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body).count).to eq(10)
      expect(Author.pluck(:id)).to include(*JSON.parse(response.body).map {|item| item["id"]})
    end
  end

  describe "create" do
    subject do
      post "/authors",
           params: params,
           as: :json,
           headers: auth_headers
    end

    describe "valid attributes" do
      let(:params) do
        {
          name: "Test 1"
        }
      end

      it { expect{ subject }.to change(Author, :count).by(1) }

      it "returns status created" do
        subject

        expect(response.status).to eq(201)
      end
    end

    describe "invalid attributes" do
      let(:params) do
        {
          name: nil
        }
      end

      it { expect{ subject }.to change(Author, :count).by(0) }

      it "returns status unprocessable_entity" do
        subject

        expect(response.status).to eq(422)
      end
    end
  end

  describe "update" do
    let(:author) { create(:author) }

    subject do
      patch "/authors/#{author.id}",
           params: params,
           as: :json,
           headers: auth_headers
    end

    describe "valid attributes" do
      let(:params) do
        {
          name: "Test 1"
        }
      end

      let(:old_name) { author.name }

      it { expect{ subject }.to change { author.reload.name }.from(old_name).to(params[:name]) }

      it "returns status ok" do
        subject

        expect(response.status).to eq(200)
      end
    end

    describe "invalid attributes" do
      let(:params) do
        {
          name: nil
        }
      end

      it { expect{ subject }.to_not change { author.reload.name } }

      it "returns status unprocessable_entity" do
        subject

        expect(response.status).to eq(422)
      end
    end
  end

  describe "destroy" do
    let!(:author) { create(:author) }

    subject do
      delete "/authors/#{author.id}", headers: auth_headers
    end
    
    describe "success path" do
      it { expect{ subject }.to change { Author.count }.from(1).to(0) }

      it "returns status ok" do
        subject

        expect(response.status).to eq(204)
      end
    end
  end
end
