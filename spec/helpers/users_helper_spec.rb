require 'spec_helper'

describe UsersHelper do
  describe "#user_list" do
    it "generate users list with github urls" do
      user = create(:user)
      helper.user_list(User.all).should match(/<a href=".*github.*#{Regexp.escape(user.github_username)}[^>]>#{Regexp.escape(user.name)}/)
    end
    
    it "should generate generate link with _blank if passed" do
      user = create(:user)
      helper.user_list(User.all, target: '_blank').should match(/target="_blank"/)
    end
  end
end
