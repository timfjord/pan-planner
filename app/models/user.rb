class User < ActiveRecord::Base
  has_many :memberships
  has_many :events, :through => :memberships
  
  attr_accessible :email, :github_url, :name
  
  validates_presence_of :email, :github_url, :name
  validates_format_of :email, with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/ 
  
  def self.tokens(query)
    where("name like ?", "#{query}%")
  end
end
