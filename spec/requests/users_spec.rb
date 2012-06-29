require 'spec_helper'

describe "Users" do
  describe "GET /users" do
    it "shows users" do
      visit users_path
      page.status_code.should be 200
    end
    
    it "should show user create page only for admin" do
      visit new_user_path
      page.status_code.should be 401
    end
  end
end
