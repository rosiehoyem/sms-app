class TextMessagesController < ApplicationController
  before_action :set_message

  def csv_upload
  end

  def import
    @message.text_messages.import(params[:file])
    redirect_to import_confirmation_message_text_messages_url, notice: "Names and phone numbers imported."
  end

	def import_confirmation
  end

  def send_sms
    client = Twilio::REST::Client.new ENV["account_sid"], ENV["auth_token"]
    from = ENV["twilio_number"]
    @message.text_messages.each do |text_message|
      client.account.messages.create(
        :from => from,
        :to => text_message.phone_number,
        :body => "Hey #{text_message.firstname}, #{@message.content}"
      ) 
    end
    redirect_to send_confirmation_message_text_messages_url
  end

  def send_confirmation
  end

	private
    def set_message
      @message = Message.find(params[:message_id])
    end

    def text_message_params
      params.require(:text_message).permit(:name, :phone, :message_id)
    end
end
