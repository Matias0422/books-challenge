module BookService
  class Builder
    private_class_method :new

    attr_accessor :params

    def self.call(*args)
      new(*args).call
    end

    def initialize(params)
      @params = params
    end

    def call
      book
    end

    private

    def book
      @book ||= begin
        Book.new.tap do |book|
          book.title = params[:title]
          book.description = params[:description]
          book.author_id = params[:author_id]

          book.picture.build(url: params[:picture_url])
        end
      end
    end
  end
end