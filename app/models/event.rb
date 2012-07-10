class Event < ActiveRecord::Base
  has_many :memberships
  has_many :users, :through => :memberships
  
  attr_accessible :at, :description, :title, :user_tokens
  attr_reader :user_tokens
  
  validates_presence_of :title, :description, :at
  
  def user_tokens=(ids)
    self.user_ids = ids.split(',')
  end
  
  class << self
    
    def for_calendar(date)
      if date.respond_to?(:year) && date.respond_to?(:month)
        date = { year: date.year, month: date.month}
      end
      raise ArgumentError if (date.keys & [:year, :month]).size < 2

      range = DateTime.civil(date[:year], date[:month], 1)..DateTime.civil(date[:year], date[:month], -1)
      where(at: range).group_by { |e| e.at.strftime('%Y%m%d') }
    end
    
    def next_event
      where('at > ?', DateTime.now).first
    end
    
  end
end
