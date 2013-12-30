class AddForeignKeyToTextMessages < ActiveRecord::Migration
  def change
    add_reference :text_messages, :message, index: true
  end
end
