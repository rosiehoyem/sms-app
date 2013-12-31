class TextMessagesController < ApplicationController

  def csv_upload
    @message = Message.find(params[:message_id])
  end

  def import
    @message = Message.find(params[:message_id])
    @message.text_messages.import(params[:file])
    redirect_to confirmation_message_text_messages_url, notice: "Names and phone numbers imported."
  end

	def confirmation
    @message = Message.find(params[:message_id])
  end

	private
    def text_message_params
      params.require(:text_message).permit(:name, :phone, :message_id)
    end
end
