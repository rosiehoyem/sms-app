class MessagesController < ApplicationController

	def new
  	@message = Message.new
  end

	def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
      	
        format.html { redirect_to csv_upload_message_text_messages_url(:message_id =>@message.id) } 
        format.json { render action: 'text_messages#csv_upload', status: :created, location: csv_upload_message_text_messages_url }
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

	private
    def message_params
      params.require(:message).permit(:content, :message_id)
    end
end
