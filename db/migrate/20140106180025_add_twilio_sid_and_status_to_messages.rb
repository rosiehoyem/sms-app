class AddTwilioSidAndStatusToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :twilio_sid, :string
    add_column :messages, :status, :string
  end
end
