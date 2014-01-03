require 'spec_helper'

describe MessagesController do

  let(:valid_attributes) { {:content => "Test Message!" } }

  # describe "GET index" do
  #   it "assigns all messages as @messages" do
  #     message = Message.create! valid_attributes
  #     get :index, {}, valid_session
  #     assigns(:messages).should eq([message])
  #   end
  # end

  describe "GET new" do
    it "assigns a new message as @message" do
      get :new, {}
      assigns(:message).should be_a_new(Message)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Message" do
        expect {
          post :create, {:message => valid_attributes}
        }.to change(Message, :count).by(1)
      end

      it "assigns a newly created message as @message" do
        post :create, {:message => valid_attributes}
        assigns(:message).should be_a(Message)
        assigns(:message).should be_persisted
      end

      it "redirects to the cvs_upload page" do
        post :create, {:message => valid_attributes}
        response.should redirect_to(csv_upload_message_text_messages_url(:message_id => 1))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved message as @message" do
        # Trigger the behavior that occurs when invalid params are submitted
        Message.any_instance.stub(:save).and_return(false)
        post :create, {:message => {:content => nil }}
        assigns(:message).should be_a_new(Message)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Message.any_instance.stub(:save).and_return(false)
        post :create, {:message => {:content => nil }}
        response.should render_template("new")
      end
    end
  end

end
