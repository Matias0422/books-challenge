require "test_helper"

class Api::V1::BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_book = api_v1_books(:one)
  end

  test "should get index" do
    get api_v1_books_url, as: :json
    assert_response :success
  end

  test "should create api_v1_book" do
    assert_difference("Api::V1::Book.count") do
      post api_v1_books_url, params: { api_v1_book: { description: @api_v1_book.description, title: @api_v1_book.title } }, as: :json
    end

    assert_response :created
  end

  test "should show api_v1_book" do
    get api_v1_book_url(@api_v1_book), as: :json
    assert_response :success
  end

  test "should update api_v1_book" do
    patch api_v1_book_url(@api_v1_book), params: { api_v1_book: { description: @api_v1_book.description, title: @api_v1_book.title } }, as: :json
    assert_response :success
  end

  test "should destroy api_v1_book" do
    assert_difference("Api::V1::Book.count", -1) do
      delete api_v1_book_url(@api_v1_book), as: :json
    end

    assert_response :no_content
  end
end
