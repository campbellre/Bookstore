module ApplicationHelper

  def no_title(title = '')
    base_title = "Book Store"
    if title.empty?
      base_title
    else
      title + " | " + base_title
    end
  end
  
end
