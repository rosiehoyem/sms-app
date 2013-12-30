class TextMessagesController < ApplicationController
  
  def new
  	@message = Message.new
  end

	def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to csv_upload_message_text_messages_url } 
        format.json { render action: 'text_messages#import', status: :created, location: csv_upload_message_text_messages_url }
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def upload_csv
    @message = Message.find(params[:id])
  end

  def import
    TextMessage.import(params[:file])
    redirect_to root_url, notice: "Names and phone numbers imported."
  end

	def confirmation
  end

	private
    def message_params
      params.require(:message).permit(:content)
    end

    def text_message_params
      params.require(:text_message).permit(:name, :phone, :message_id)
    end
end
