require 'spec_helper'

describe User do
  it "should be invalide without email" do
    build(:user, email: nil).should_not be_valid
  end
  
  it "should be invalide without github_url" do
    build(:user, github_url: nil).should_not be_valid
  end
  
  it "should be invalide without name" do
    build(:user, name: nil).should_not be_valid
  end
  
  it "should have valid email address" do
    build(:user, email: "test@test").should_not be_valid
  end
  
  it "should work correct with tokens method" do
    create(:user, name: "Superman")
    User.should respond_to :tokens
    user = User.tokens("Super").first
    user.should_not be_nil
    user.name.should match("Superman")
  end
  
  it "should search search with name% format in tokens method" do
    create(:user, name: "Superman")
    User.tokens("man").should be_empty
  end
end
