require 'spec_helper'

describe "Events" do
  include AuthHelper
  
  describe "GET /events" do
    it "should be accessible" do
      visit events_path
      page.status_code.should be 200
    end
    
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
    
    it "should show next event" do
      event = create(:event, at: DateTime.tomorrow)
      visit events_path
      page.should have_selector('div.next_event p', text: event.title)
    end
    
    it "should include edges date" do
      event = create(:event, at: DateTime.new(2012, 6, 30), title: 'Egde event')
      visit events_path(year: 2012, month: 7)
      page.should have_content(event.title)
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
  
  describe "GET /events/:event_id" do
    it "should be accessible" do
      event = create(:event)
      visit event_path(event)
      page.status_code.should be 200
    end
  end
end
