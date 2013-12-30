class CreateTextMessages < ActiveRecord::Migration
  def change
    create_table :text_messages do |t|
      t.string :phone_number
      t.string :firstname

      t.timestamps
    end
  end
end
