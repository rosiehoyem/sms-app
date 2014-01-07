require 'spec_helper'
require 'feature_helper'

feature "Send SMS" do
  scenario "add new message" do
    visit root_path
    fill_in '#content', with: 'Test message.'
    click_link 'Create Message'
    expect(current_path).to eq import_message_text_messages_path
    expect(page).to have_content 'Great! Your message to be sent:'
  end

  scenario "uploads a CSV file and sends SMS" do
    visit import_message_text_messages_path(message_id: 1)
    page.attach_file("file_upload", "./spec/data/valid_csv.csv") 
    click_button "Import"
    expect(current_path).to eq import_confirmation_message_text_messages_url
    expect(page).to have_content "Phone numbers uploaded: 2"

    click_button "Send!"
    expect(current_path).to eq send_confirmation_message_text_messages_url
    expect(page).to have_content "Message status: SENT"
  end
end
