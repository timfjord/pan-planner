require 'spec_helper'

describe Event do
  it "should be invalid without title" do
    build(:event, title: nil).should_not be_valid
  end
  
  it "should be invalid without description" do
    build(:event, description: nil).should_not be_valid
  end
  
  it "should be invalid without at" do
    build(:event, at: nil).should_not be_valid
  end
  
  describe '#for_calendar' do
    it "should return hash with events, and hash key should be DateTime string" do
      current_date = DateTime.now
      param = { year: current_date.year, month: current_date.month }
      event = create(:event, at: current_date)
      events = Event.for_calendar(param)
      events.should be_a_kind_of(Hash)
      events.keys.should include(current_date.strftime('%Y%m%d'))
    end
  
    it "should allow DateTime object" do
      current_date = DateTime.now
      event = create(:event, at: current_date)
      events = Event.for_calendar(current_date)
      events.should be_a_kind_of(Hash)
      events.keys.should include(current_date.strftime('%Y%m%d'))
    end
    
    it "should allow Range object" do
      current_date = DateTime.now
      event = create(:event, at: current_date)
      events = Event.for_calendar(current_date.beginning_of_month..current_date.end_of_month)
      events.should be_a_kind_of(Hash)
      events.keys.should include(current_date.strftime('%Y%m%d'))
    end
  
    it "should raise ArgumentError when passed wrong params to for_celendar method" do
      lambda { Event.for_calendar }.should raise_error(ArgumentError)
      lambda { Event.for_calendar(year: 2012) }.should raise_error(ArgumentError)
      lambda { Event.for_calendar(month: 2012) }.should raise_error(ArgumentError)
      lambda { Event.for_calendar(year: 2012, month: 12) }.should_not raise_error(ArgumentError)
    end
  end
  
  describe "#next_event" do
    it "should return next event" do
      event = create(:event, at: DateTime.tomorrow)
      next_event = Event.next_event
      next_event.should_not be_nil
      next_event.should == event
    end
  end
end
