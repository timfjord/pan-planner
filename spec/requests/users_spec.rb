require 'spec_helper'

describe "Users" do
  describe "GET /users" do
    it "shows users" do
      visit users_path
      page.status_code.should be 200
    end
    
    it "should allow user view only index page" do
      visit new_user_path
      page.status_code.should be 401
    end
    
    it "should be invalide without email" do
      build(:user, email: nil).should_not be_valid
    end
    
    it "should be invalide without github_url" do
      build(:user, github_url: nil).should_not be_valid
    end
    
    it "should be invalide without name" do
      build(:user, name: nil).should_not be_valid
    end
    
    it "should have valide email address" do
      build(:user, email: "test@test").should_not be_valid
    end
  end
end
