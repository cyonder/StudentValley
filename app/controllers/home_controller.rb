class HomeController < ApplicationController
  layout 'home'
  before_action :confirm_not_logged_in, only: [:index]

  def index
  end

  def about
  end

  def contact
  end

  def faq
  end

  def privacy
  end
end
