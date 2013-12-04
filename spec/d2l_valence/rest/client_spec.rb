require 'helper'

describe D2LValence::REST::Client do
  
  before do
    @client = D2LValence::REST::Client.new(
      :app_id => "G9nUpvbZQyiPrk3um2YAkQ", 
      :app_key => "ybZu7fm_JKJTFwKEHfoZ7Q", 
      :user_id => "5mPT19xiP8w0iP6Na21jYp", 
      :user_key => "d2uu5qe3bW__MF_QMbwAcQ")
  end
  
  
  # https://valence.desire2learn.com/d2l/api/lp/1.0/users/whoami
    # ?x_a=G9nUpvbZQyiPrk3um2YAkQ
    # &x_b=5mPT19xiP8w0iP6Na21jYp
    # &x_d=anMRUTIYBD0HpRD_g-lFq9Arq9pAd8stnKD_LA10fOM
    # &x_c=ZEadERkd9QUJ-66yii53v0x98UQLSoOtLguh9wzQmSQ
    # &x_t=1386026234
  
  describe "#who am i" do
    context "return the WhoAmIUser user" do
      #From Valence docs http://docs.valence.desire2learn.com/res/user.html#User.WhoAmIUser
      it "returns a WhoAmIUser User block" do
        binding.pry
        @client.whoami.to_return(:body => '{
            "Identifier": "3675",
            "FirstName": "sample",
            "LastName": "apiuser",
            "UniqueName": "sampleapiuser",
            "ProfileIdentifier": "jWORDXkt6s"
        }')
      end
    end
  end
  
end
