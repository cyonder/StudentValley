class Book < ActiveRecord::Base
  belongs_to :seller, class_name: 'User', foreign_key: :seller_id

  # ---------------------------------------------------------------------------- #
  # -- Validation Logic -------------------------------------------------------- #
  # ---------------------------------------------------------------------------- #

  # -- Title ------------------------------------------------------------------- #
  validates :title,
            presence: {message: 'Title cannot be blank'},
            length: {within: 6..100, message: 'Title length should be within 6 to 100 characters'}

  # -- Description ------------------------------------------------------------- #
  validates :description,
            presence: {message: 'Description cannot be blank'},
            length: {minimum: 10, message: 'Description length should be minimum 10 characters'}

  # -- Category ---------------------------------------------------------------- #
  validates :category,
            presence: {message: 'Please choose a category for your ad'}

  # -- Price ------------------------------------------------------------------- #
  validates :price,
            presence: {message: 'Price cannot be blank'},
            length: {maximum: 8, message: 'Price cannot be higher than 99,999.99'}

  # ---------------------------------------------------------------------------- #
  # -- Paperclip --------------------------------------------------------------- #
  # ---------------------------------------------------------------------------- #

  has_attached_file :photo, styles: { book: '210x', thumb: '100x100#' }, default_url: '/missing_book_photo.png'

  validates_attachment :photo,
                       content_type: {content_type: ['image/jpeg', 'image/png'], message: 'Please upload a photo with jpeg and png extensions only'},
                       size: {less_than: 2.megabytes, message: 'The size of photo should be less than 2 megabytes'}

  def book_time
    if updated_at.to_date == Date.today
      updated_at.strftime('Today, %l:%M%P')
    elsif updated_at.to_date == Date.yesterday
      updated_at.strftime('Yesterday, %l:%M%P')
    else
      updated_at.strftime('%b %d, %l:%M%P')
    end
  end
end
