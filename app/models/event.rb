class Event < ActiveRecord::Base
  attr_accessible :at, :description, :title
end
