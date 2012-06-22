class User < ActiveRecord::Base
  attr_accessible :github_url, :name
end
