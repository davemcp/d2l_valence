require 'helper'

describe D2LValence::Version do
  
  it "returns the correct version" do
    expect(D2LValence::Version.to_s).to eq("0.0.1")
  end
  
end