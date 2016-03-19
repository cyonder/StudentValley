require 'digest/sha1'

class User < ActiveRecord::Base
  # ---------------------------------------------------------------------------- #
  # -- Associations ------------------------------------------------------------ #
  # ---------------------------------------------------------------------------- #

  has_many :friendships
  has_many :friends, -> { where(friendships: {status: 'accepted'}).order('updated_at') }, through: :friendships
  has_many :requested_friends, -> { where(friendships: {status: 'requested'}).order('updated_at') }, through: :friendships, source: :friend
  has_many :pending_friends, -> { where(friendships: {status: 'pending'}).order('updated_at') }, through: :friendships, source: :friend

  has_many :messages
  has_many :books

  # ---------------------------------------------------------------------------- #
  # -- Callbacks --------------------------------------------------------------- #
  # ---------------------------------------------------------------------------- #

  before_create :generate_authorization_token
  before_create :create_hashed_password
  after_create :clear_password

  # ---------------------------------------------------------------------------- #
  # -- Authentication Logic ---------------------------------------------------- #
  # ---------------------------------------------------------------------------- #
  #
  # Some part of authentication logic is in sessions_controller (create). Because,
  # Student Valley's authentication tells user, separately, if the password or the
  # email/username entered wrong. To be able to do that, we needed to define some
  # part of authentication logic in controller.
  # ---------------------------------------------------------------------------- #

  def password_match?(entered_password = '')
    password == User.hash_with_salt(entered_password, salt)
  end

  def generate_authorization_token
    begin
      self.authorization_token = SecureRandom.uuid
    end while User.exists?(authorization_token: authorization_token)
  end

  # ---------------------------------------------------------------------------- #
  # -- Password Hashing Logic -------------------------------------------------- #
  # ---------------------------------------------------------------------------- #
  #
  # Password salt is generated with user's email and the time user signed up, by
  # using SHA1. And user's password is hashed with the salt by using SHA1 again.
  # ---------------------------------------------------------------------------- #

  def self.generate_salt(email = '')
    Digest::SHA1.hexdigest("#{email}#{Time.now.to_s}")
  end

  def self.hash_with_salt(password = '', salt = '')
    Digest::SHA1.hexdigest("#{password}#{salt}")
  end

  def create_hashed_password
    if password.present?
      self.salt = User.generate_salt(email)
      self.password = User.hash_with_salt(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end

  # ---------------------------------------------------------------------------- #
  # -- Validation Logic -------------------------------------------------------- #
  # ---------------------------------------------------------------------------- #

  EMAIL = /\A^[A-Za-z0-9](([_\.\-]?[a-zA-Z0-9]+)*)@([A-Za-z0-9]+)(([\.\-]?[a-zA-Z0-9]+)*)\.([A-Za-z]{2,})$\z/
  ALL_LETTERS_AND_SINGLE_SPACES = /\A^([a-zA-Z]+\s?)*$\z/
  ALL_LETTERS_AND_NUMBERS = /\A^[A-Za-z0-9_]+$\z/
  WEBSITE = /\A(www.)?([a-zA-Z0-9]+).[a-zA-Z0-9]*.[a-z]{3}.?([a-z]+)?\z/

  # TODO: Make sure REGEXs works perfect.
  # TODO: Add maximum limit for all validations.

  # -- First Name -------------------------------------------------------------- #
  validates :first_name,
            presence: {message: 'First name cannot be blank'},
            length: {maximum: 50, message: 'First name cannot be longer than 50 characters'},
            format: {with: ALL_LETTERS_AND_SINGLE_SPACES, message: 'First name should contain only letters and single space'},
            if: :first_name_changed?

  # -- Last Name --------------------------------------------------------------- #
  validates :last_name,
            presence: {message: 'Last name cannot be blank'},
            length: {maximum: 50, message: 'Last name cannot be longer than 50 characters'},
            format: {with: ALL_LETTERS_AND_SINGLE_SPACES, message: 'Last name should contain only letters and single space'},
            if: :last_name_changed?

  # -- Email ------------------------------------------------------------------- #
  validates :email,
            presence: {message: 'Email cannot be blank'},
            length: {maximum: 100, message: 'Email cannot be longer than 100 characters'},
            format: {with: EMAIL, message: 'Email is not valid'},
            uniqueness: {case_sensitive: false, message: 'This email is already registered'},
            confirmation: {message: 'Email address does not match'},
            if: :email_changed?

  # TODO: WARNING! If you uncomment this, settings page won't save, because it will be validating email_confirmation presence.
  # validates_presence_of :email_confirmation, message: 'Confirmation email cannot be blank'

  # -- Password ---------------------------------------------------------------- #
  validates :password,
            presence: {message: 'Password cannot be blank'},
            length: {minimum: 8, message: 'Password length should be minimum 8 characters'},
            if: Proc.new {new_record? || !password.nil?}

  # -- Username ---------------------------------------------------------------- #
  validates :username,
            presence: {message: 'Username cannot be blank'},
            length: {minimum: 3, message: 'Username cannot be shorter than 3 characters'},
            format: {with: ALL_LETTERS_AND_NUMBERS, message: 'Username should contain only letters, numbers and underscore'},
            uniqueness: {case_sensitive: false, message: 'This username is already in use'},
            if: :username_changed?

  # -- Website ----------------------------------------------------------------- #
  validates :website,
            format: {with: WEBSITE, message: 'Invalid email format. Make sure you don\'t have http:// in your link'},
            allow_blank: true

  # -- Information ------------------------------------------------------------- #
  validates :information,
            length: {maximum: 150, message: 'Information cannot be longer than 150 characters'}

  # ---------------------------------------------------------------------------- #
  # -- Paperclip --------------------------------------------------------------- #
  # ---------------------------------------------------------------------------- #

  has_attached_file :photo, styles: { profile: '210x', thumb: '100x100#' }, default_url: '/missing_profile_photo.png'

  validates_attachment :photo,
                       content_type: {content_type: ['image/jpeg', 'image/png'], message: 'Please upload a photo with jpeg and png extensions only'},
                       size: {less_than: 2.megabytes, message: 'The size of photo should be less than 2 megabytes'}

  # ---------------------------------------------------------------------------- #
  # -- Other Methods ----------------------------------------------------------- #
  # ---------------------------------------------------------------------------- #

  def join_date
    created_at.strftime('%b %d, %Y')
  end

  def change_password(current_password, password, password_confirmation)
    if password_match?(current_password)
      if password == password_confirmation
        if password.present?
          if password.length >= 8
            self.salt = User.generate_salt(self.email)
            self.password = User.hash_with_salt(password, self.salt)
            save
          else
            errors.add(:password, 'New password length should be minimum 8 characters') and false
          end
        else
          errors.add(:password, 'New password cannot be blank') and false
        end
      else
        errors.add(:password, 'New password does not match the confirmation password') and false
      end
    else
      errors.add(:password, 'The current password you entered is incorrect') and false
    end
  end
end
