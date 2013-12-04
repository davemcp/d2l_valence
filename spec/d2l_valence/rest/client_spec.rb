require 'helper'

describe D2LValence::REST::Client do
  
  before(:all) do
    @client = D2LValence::REST::Client.new(
      :end_point  => "https://valence.desire2learn.com",
      :app_id     => "G9nUpvbZQyiPrk3um2YAkQ", 
      :app_key    => "ybZu7fm_JKJTFwKEHfoZ7Q", 
      :user_id    => "5mPT19xiP8w0iP6Na21jYp", 
      :user_key   => "d2uu5qe3bW__MF_QMbwAcQ")
      # binding.pry
  end
  
  describe "#client calls" do
    
    before do
      @client.set_d2l_connection_params("GET", "/d2l/api/versions/")
      @request = @client.get "/d2l/api/versions/"
    end
    
    it "responds with 200" do
      @request[:status].should equal(200)
    end
    
    it "returns JSON" do
      expect(@request[:response_headers]["content-type"]).to eq("application/json; charset=UTF-8")
    end
    
    it "returns a signature based on method, path, user id and timestamp" do
      expect(@client.signed("get", "/d2l/api/lp/1.0/users/whoami", "d2uu5qe3bW__MF_QMbwAcQ", 1386128336)).to eq("y2zrHI9wFNLhlUkC-JcPlQotVrvelM_dFfTdpt_FfNA")
    end
    
  end
  
  describe "#who am i" do
    #From Valence docs http://docs.valence.desire2learn.com/res/user.html#User.WhoAmIUser
    it "returns a WhoAmIUser User" do
      user = @client.whoami
      user.should be_an_instance_of D2LValence::REST::API::WhoamiUser
    end
  end
  
end
