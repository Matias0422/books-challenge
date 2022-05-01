require "test_helper"

class Api::V1::AuthorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_author = api_v1_authors(:one)
  end

  test "should get index" do
    get api_v1_authors_url, as: :json
    assert_response :success
  end

  test "should create api_v1_author" do
    assert_difference("Api::V1::Author.count") do
      post api_v1_authors_url, params: { api_v1_author: { name: @api_v1_author.name } }, as: :json
    end

    assert_response :created
  end

  test "should show api_v1_author" do
    get api_v1_author_url(@api_v1_author), as: :json
    assert_response :success
  end

  test "should update api_v1_author" do
    patch api_v1_author_url(@api_v1_author), params: { api_v1_author: { name: @api_v1_author.name } }, as: :json
    assert_response :success
  end

  test "should destroy api_v1_author" do
    assert_difference("Api::V1::Author.count", -1) do
      delete api_v1_author_url(@api_v1_author), as: :json
    end

    assert_response :no_content
  end
end
