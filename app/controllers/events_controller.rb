class EventsController < ApplicationController
  inherit_resources
  
  http_basic_authenticate_with name: ENV['HTTP_USER'] || 'admin', password: ENV['HTTP_PASSWORD'] || 'admin', except: [:index, :show]
  
  def index
    date_params = params.symbolize_keys.slice(:year, :month).transform_values(&:to_i)
    @event_date = DateTime.now.change date_params
    # refactor this in the future, to avoid duplication
    calendar = LaterDude::Calendar.new(@event_date.year, @event_date.month, first_day_of_week: 1)
    @events = Event.for_calendar(calendar.first_rendered_date..calendar.last_rendered_date)
    @next_event = Event.next_event
    index!
  end
end
