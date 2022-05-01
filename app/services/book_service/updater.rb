module BookService
  class Updater
    private_class_method :new

    attr_accessor :params

    def self.call(*args)
      new(*args).call
    end

    def initialize(book, params)
      @book = book
      @params = params
    end

    def call
      set_picture_url

      book.save
    end

    private

    def set_picture_url
      book.picture = Picture.find_or_initialize_by(id: book.picture&.id, url: params[:picture_url])
    end
  end
end