class AddForeignKeyToSms < ActiveRecord::Migration
  def change
    add_reference :sms, :message, index: true
  end
end
