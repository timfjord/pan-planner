require 'spec_helper'

describe "Events" do
  include AuthHelper
  
  describe "GET /events" do
    it "shows events with calendar" do
      event = create(:event, at: DateTime.now)
      visit events_path
      page.should have_css 'table.calendar'
      page.should have_content(event.title)
    end
    
    it "should contains add event button" do
      visit events_path
      page.should have_content('Add event')
    end
    
    it "should generate correct month" do
      current_date = DateTime.now
      visit events_path
      page.should have_content(current_date.year)
      page.should have_content(current_date.strftime('%B'))
    end
  end  
   
  describe "GET /events/new" do
    it "should allow user view only index page" do
      visit new_event_path
      page.status_code.should be 401
    end
    
    it "should create event" do
      user1 = create(:user, name: "User1")
      user2 = create(:user, name: "User2")
      
      basic_auth
      visit new_event_path
      
      tomorrow = Date.tomorrow
      
      fill_in 'Title', with: 'Event title'
      fill_in 'Description', with: 'Event description'
      select tomorrow.year.to_s, from: 'event_at_1i'
      select tomorrow.strftime('%B'), from: 'event_at_2i'
      select tomorrow.day.to_s, from: 'event_at_3i'
      select tomorrow.strftime('%H'), from: 'event_at_4i'
      select tomorrow.strftime('%M'), from: 'event_at_5i'
      fill_in "event_user_tokens", with: [user1.id, user2.id].join(',')
      click_button "Create Event"
      
      page.status_code.should be 200
    end
  end
end
