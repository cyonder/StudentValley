module BooksHelper
  def options_for_categories
    ['Biographies',
     'Children\'s Books',
     'Comics & Graphic Novels',
     'Literature & Fiction',
     'Magazines',
     'Textbooks',
     'Young Adult',
     'Other']
  end

  def books_error_messages_for(object)
    render partial: 'books/error_messages', locals: {object: object}
  end
end
