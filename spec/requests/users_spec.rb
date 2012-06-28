require 'spec_helper'

describe "Users" do
  describe "GET /users" do
    it "should shows users" do
      visit users_path
      page.status_code.should be 200
    end
  end
end
