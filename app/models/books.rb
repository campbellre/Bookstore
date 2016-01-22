class Books
  include Cequel::Record

  key :isbn, :text
  column :title, :text
  column :author, :text
  column :genre, :text
  column :publisher, :text
  set :tags, :text
  column :data, :blob
  
end
