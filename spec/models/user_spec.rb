require 'spec_helper'

describe User do
  it "should be invalide without email" do
    build(:user, email: nil).should_not be_valid
  end
  
  it "should be invalide without github_username" do
    build(:user, github_username: nil).should_not be_valid
  end
  
  it "should be invalide without name" do
    build(:user, name: nil).should_not be_valid
  end
  
  it "should have valid email address" do
    build(:user, email: "test@test").should_not be_valid
  end
  
  describe '#tokens' do
    it "should search for users" do
      create(:user, name: "Superman")
      user = User.tokens("Super").first
      user.should_not be_nil
      user.name.should match("Superman")
    end

    it "should search search with name%" do
      create(:user, name: "Superman")
      User.tokens("man").should be_empty
    end
  end
end
