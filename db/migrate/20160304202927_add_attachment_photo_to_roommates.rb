class AddAttachmentPhotoToRoommates < ActiveRecord::Migration
  def self.up
    change_table :roommates do |t|
      t.attachment :photo, after: :parking_spot
    end
  end

  def self.down
    remove_attachment :roommates, :photo
  end
end
