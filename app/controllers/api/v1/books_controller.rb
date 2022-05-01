class Api::V1::BooksController < ApplicationController
  before_action :set_api_v1_book, only: %i[ show update destroy ]

  # GET /api/v1/books
  def index
    @api_v1_books = Api::V1::Book.all

    render json: @api_v1_books
  end

  # GET /api/v1/books/1
  def show
    render json: @api_v1_book
  end

  # POST /api/v1/books
  def create
    @api_v1_book = Api::V1::Book.new(api_v1_book_params)

    if @api_v1_book.save
      render json: @api_v1_book, status: :created, location: @api_v1_book
    else
      render json: @api_v1_book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/books/1
  def update
    if @api_v1_book.update(api_v1_book_params)
      render json: @api_v1_book
    else
      render json: @api_v1_book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/books/1
  def destroy
    @api_v1_book.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_book
      @api_v1_book = Api::V1::Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_book_params
      params.require(:api_v1_book).permit(:title, :description)
    end
end
