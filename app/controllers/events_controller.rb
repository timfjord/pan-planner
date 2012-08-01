class EventsController < ApplicationController
  inherit_resources
  
  http_basic_authenticate_with name: ENV['HTTP_USER'] || 'admin', password: ENV['HTTP_PASSWORD'] || 'admin', except: [:index, :show]
  
  def index
    date_params = params.symbolize_keys.slice(:year, :month).transform_values(&:to_i)
    @event_date = DateTime.now.change date_params
    @calendar = LaterDude::Calendar.new(@event_date.year, @event_date.month, use_full_day_names: true, first_day_of_week: 1, hide_month_name: true, yield_surrounding_days: true)
    @events = Event.for_calendar(@calendar.first_rendered_date..@calendar.last_rendered_date)
    @next_event = Event.next_event
    index!
  end
end
