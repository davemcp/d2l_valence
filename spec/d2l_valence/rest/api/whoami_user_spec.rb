require 'helper'

describe D2LValence::REST::API::WhoamiUser do
  
  before do
    moq_response = {
      :method=>:get,
      :body =>  "{\"Identifier\":\"3675\",
                  \"FirstName\":\"sample\",
                  \"LastName\":\"apiuser\",
                  \"UniqueName\":\"sampleapiuser\",
                  \"ProfileIdentifier\":\"jWORDXkt6s\"}",
     :url=> "https://valence.desire2learn.com/d2l/api/lp/1.0/users/whoami?x_a=G9nUpvbZQyiPrk3um2YAkQ&x_b=5mPT19xiP8w0iP6Na21jYp&x_c=PXowduZIkBMUGvHSGWrYGH4JcXosfuU-iF0fHyoawFc&x_d=B97q8F44wd4x_wfkXlhrJQHaKSjneJ1l1xQoxv7jKdI&x_t=1386127161",
     :request_headers=>
      {"Accept"=>"application/json", "User-Agent"=>"Faraday v0.8.8"},
     :parallel_manager=>nil,
     :request=>{:open_timeout=>5, :timeout=>10, :proxy=>nil},
     :ssl=>{},
     :status=>200,
     :response_headers=>
      {"cache-control"=>"no-cache, no-store",
       "pragma"=>"no-cache",
       "content-length"=>"125",
       "content-type"=>"application/json; charset=UTF-8",
       "expires"=>"-1",
       "server"=>"Microsoft-IIS/6.0",
       "x-powered-by"=>"ASP.NET",
       "date"=>"Wed, 04 Dec 2013 03:19:54 GMT",
       "connection"=>"close"},
     :response=> "not needed"}
    @whoami_user = D2LValence::REST::API::WhoamiUser.new moq_response
  end
  
  it "returns a WhoamiUser" do
    @whoami_user.should be_an_instance_of D2LValence::REST::API::WhoamiUser
  end
  
  it "uses only the body" do
    @whoami_user.status.should be_nil
  end
  
  it "returns the correct identifier" do
    expect(@whoami_user.identifier).to eq("3675")
  end
  
  it "returns the correct attributes using underscored keys" do
    expect(@whoami_user.first_name).to eq("sample")
    expect(@whoami_user.last_name).to eq("apiuser")
    expect(@whoami_user.unique_name).to eq("sampleapiuser")
    expect(@whoami_user.profile_identifier).to eq("jWORDXkt6s")
  end
  
end