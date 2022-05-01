class Api::V1::AuthorsController < ApplicationController
  before_action :set_api_v1_author, only: %i[ show update destroy ]

  # GET /api/v1/authors
  def index
    @api_v1_authors = Api::V1::Author.all

    render json: @api_v1_authors
  end

  # GET /api/v1/authors/1
  def show
    render json: @api_v1_author
  end

  # POST /api/v1/authors
  def create
    @api_v1_author = Api::V1::Author.new(api_v1_author_params)

    if @api_v1_author.save
      render json: @api_v1_author, status: :created, location: @api_v1_author
    else
      render json: @api_v1_author.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/authors/1
  def update
    if @api_v1_author.update(api_v1_author_params)
      render json: @api_v1_author
    else
      render json: @api_v1_author.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/authors/1
  def destroy
    @api_v1_author.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_author
      @api_v1_author = Api::V1::Author.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_author_params
      params.require(:api_v1_author).permit(:name)
    end
end
