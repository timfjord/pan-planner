class Event < ActiveRecord::Base
  has_many :memberships
  has_many :users, :through => :memberships
  
  attr_accessible :at, :description, :title
end
