class BooksController < ApplicationController
  before_action :confirm_logged_in

  def index
    case params[:category]
      when 'biographies'
        @books = Book.where(category: 'Biographies').order('updated_at desc')
      when 'children-s-books'
        @books = Book.where(category: 'Children\'s Books').order('updated_at desc')
      when 'comics-and-graphic-novels'
        @books = Book.where(category: 'Comics & Graphic Novels').order('updated_at desc')
      when 'literature-and-fiction'
        @books = Book.where(category: 'Literature & Fiction').order('updated_at desc')
      when 'magazines'
        @books = Book.where(category: 'Magazines').order('updated_at desc')
      when 'textbooks'
        @books = Book.where(category: 'Textbooks').order('updated_at desc')
      when 'young-adult'
        @books = Book.where(category: 'Young Adult').order('updated_at desc')
      when 'other'
        @books = Book.where(category: 'Other').order('updated_at desc')
      else
        @books = Book.order('updated_at desc')
    end

    @my_books = Book.where(seller_id: current_user.id).order('updated_at desc')
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_parameters)
    @book.seller_id = current_user.id

    if @book.save
      flash[:notice] = 'Your book ad has been created successfully'
      redirect_to book_path(@book.id) # Redirect to created ad's page.
    else
      @book.errors.delete(:photo) # Necessary to prevent duplicate error messages caused by Paperclip
      render 'new'
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])

    if @book.update_attributes(book_parameters)
      redirect_to book_path(@book.id) # Redirect to updated ad's page.
    else
      @book.errors.delete(:photo) # Necessary to prevent duplicate error messages caused by Paperclip
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])

    # TODO: You should be able to delete your own ad only. FIX.
    # if @book.friends.include?(@friend)
    #   @book.destroy
    # end

    redirect_to request.referrer
  end

  def update_date
    @book = Book.find(params[:id])
    @book.updated_at = Time.now

    # cookies.delete(:book_update_date)
    # Setting up cookie for each book ads for user.
    cookie_name = 'book_update_date' + params[:id]
    if !cookies[cookie_name]
      cookies[cookie_name] = {
          value: Time.now,
          expires: 5.hours.from_now
      }
      if @book.save
        flash[:success] = 'Your post has been reposted'
      else
        redirect_to request.referrer
      end
    else
      flash[:error] = 'You can only repost each of your ads every 5 hours'
      # TODO: Find a way to print count down from 5 hours, in the error.
      # puts Time.now - cookies[cookie_name].to_i
    end

    redirect_to request.referrer
  end

  private
  def book_parameters
    params.require(:book).permit(:title, :description, :category, :price, :photo)
  end
end
