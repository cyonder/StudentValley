class Message < ActiveRecord::Base
  # ---------------------------------------------------------------------------- #
  # -- Scopes ------------------------------------------------------------------ #
  # ---------------------------------------------------------------------------- #
  scope :all_messages, -> (id, current_user) {where('(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)', id, current_user, current_user, id).order('created_at')}
  scope :all_unread_messages,-> (current_user) {where('(recipient_id = ? AND `read` = 0)', current_user)}
  scope :user_unread_messages,-> (id, current_user) {where('((sender_id = ? AND recipient_id = ?) AND `read` = 0)', id, current_user)}

  # ---------------------------------------------------------------------------- #
  # -- Associations ------------------------------------------------------------ #
  # ---------------------------------------------------------------------------- #

  belongs_to :sender, class_name: 'User', foreign_key: :sender_id
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id

  validates_presence_of :sender_id, :recipient_id, :message

  def message_time
    if created_at.to_date == Date.today
      created_at.strftime('%l:%M%P')
    else
      created_at.strftime('%b %d, %l:%M%P')
    end
  end
end
