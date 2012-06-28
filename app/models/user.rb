class User < ActiveRecord::Base
  attr_accessible :email, :github_url, :name
end
