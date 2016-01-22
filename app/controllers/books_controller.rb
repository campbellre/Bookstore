class BooksController < ApplicationController
  def new
  end

  def index
    @books = Books.all
  end
  
  def show
    @book = Books.find_by_isbn(params[:id])
  end
end
