class DataController < ApplicationController
  def index
    @book = Books.find_by_isbn(params[:book_id])
  end 
end
