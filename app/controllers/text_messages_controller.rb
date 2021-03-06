class TextMessagesController < ApplicationController
  before_action :set_message

  def csv_upload
  end

  def import
    @message.text_messages.import(params[:file])
    redirect_to import_confirmation_message_text_messages_url, notice: "Names and phone numbers imported."
  end

	def import_confirmation
    client = Twilio::REST::Client.new(ENV["ACCOUNT_SID"], ENV["AUTH_TOKEN"])
    account = client.accounts.get(ENV["ACCOUNT_SID"])
    from = ENV["TWILIO_NUMBER"]
    @status = client.account.status
  end

  def send_sms
    client = Twilio::REST::Client.new(ENV["ACCOUNT_SID"], ENV["AUTH_TOKEN"])
    account = client.accounts.get(ENV["ACCOUNT_SID"])
    from = ENV["TWILIO_NUMBER"]
    @message.text_messages.each do |text_message|
      client.account.messages.create(
        :from => from,
        :to => text_message.phone_number.gsub(/^(\+1)|[^0-9]+/,''),
        :body => "Hey #{text_message.firstname}, #{@message.content}"
      ) 
    end
    redirect_to send_confirmation_message_text_messages_url
  end

  def send_confirmation
    client = Twilio::REST::Client.new(ENV["ACCOUNT_SID"], ENV["AUTH_TOKEN"])
    account = client.accounts.get(ENV["ACCOUNT_SID"])
    @message.twilio_sid = client.account.messages.list.last.sid
    @message.date_sent = client.account.messages.list.last.date_sent
    @message.status = client.account.messages.list.last.status
    @message.save
  end

	private
    def set_message
      @message = Message.find(params[:message_id])
    end

    def text_message_params
      params.require(:text_message).permit(:name, :phone, :message_id, :text_message)
    end
end
