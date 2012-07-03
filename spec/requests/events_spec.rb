require 'spec_helper'

describe "Events" do
  describe "GET /events" do
    it "shows events with calendar" do
      visit events_path
      page.should have_css 'table.calendar'
    end
    
    it "should allow user view only index page" do
      visit new_event_path
      page.status_code.should be 401
    end
    
    it "should generate correct month" do
      current_date = DateTime.now
      visit events_path
      page.should have_content(current_date.year)
      page.should have_content(current_date.strftime('%B'))
    end
  end
end
