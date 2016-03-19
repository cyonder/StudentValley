class Friendship < ActiveRecord::Base
  # ---------------------------------------------------------------------------- #
  # -- Associations ------------------------------------------------------------ #
  # ---------------------------------------------------------------------------- #

  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  # ---------------------------------------------------------------------------- #
  # -- Validation Logic -------------------------------------------------------- #
  # ---------------------------------------------------------------------------- #

  validates_presence_of :user_id, :friend_id

  # ---------------------------------------------------------------------------- #
  # -- Connection Logic -------------------------------------------------------- #
  # ---------------------------------------------------------------------------- #

  # -- Create A Friendship Request --------------------------------------------- #
  def self.send_request(user, friend)
    unless user == friend or Friendship.exists?(user, friend)
      transaction do
        create(user: user, friend: friend, status: 'pending')
        create(user: friend, friend: user, status: 'requested')
      end
    end
  end

  # -- Accept Friendship Request ----------------------------------------------- #
  def self.accept_request(user, friend)
    transaction do
      accept_one_side(user, friend)
      accept_one_side(friend, user)
    end
  end

  # -- Decline Friendship Request, Disconnect or Cancel Pending Request -------- #
  def self.breakup(user, friend)
    transaction do
      destroy(find_by_user_id_and_friend_id(user, friend))
      destroy(find_by_user_id_and_friend_id(friend, user))
    end
  end

  # -- Return True If The Users Are (Possibly Pending) Friends ----------------- #
  def self.exists?(user, friend)
    not find_by_user_id_and_friend_id(user, friend).nil?
  end

  # -- Update The DB With One Side of An Accepted Friendship Request ----------- #
  private
  def self.accept_one_side(user, friend)
    request = find_by_user_id_and_friend_id(user, friend)
    request.status = 'accepted'
    request.save!
  end
end
