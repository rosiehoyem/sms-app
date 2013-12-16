require 'spec_helper'

describe SmsController do

  describe "GET 'send'" do
    it "returns http success" do
      get 'send'
      response.should be_success
    end
  end

  describe "GET 'confirmation'" do
    it "returns http success" do
      get 'confirmation'
      response.should be_success
    end
  end

end
