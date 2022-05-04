class BooksController < ApplicationController
  include RackSessionFix

  before_action :authenticate_user!
  before_action :set_book, only: %i[ show update destroy favorite ]

  load_and_authorize_resource

  has_scope :by_author_id
  has_scope :by_text_on_name_or_description
  has_scope :by_text_on_author_name
  has_scope :order_by_title
  has_scope :by_user_favorites, type: :boolean do |controller, scope|
    scope.merge(controller.current_user.favorite_books)
  end

  # GET /books
  def index
    @books = apply_scopes(Book).page(params[:page]).per(10)

    render json: @books
  end

  # POST /books
  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book, status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
  end

  # PATCH /books/1/favorite
  def favorite
    @book.users_who_favorited << current_user
  rescue ActiveRecord::RecordNotUnique, ActiveRecord::AssociationTypeMismatch
    head :unprocessable_entity
  end

  # PATCH /books/1/unfavorite
  def unfavorite
    @book.users_who_favorited.destroy(current_user)
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(
        :title,
        :description,
        :author_id,
        picture_attributes: [:id, :url],
        authors_attributes: [:id, :name],
        users_who_favorited_attributes: [:id, :_destroy]
      )
    end
end
