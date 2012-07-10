class EventsController < ApplicationController
  inherit_resources
  
  http_basic_authenticate_with name: ENV['HTTP_USER'], password: ENV['HTTP_PASSWORD'], except: [:index, :show]
  
  def index
    date_params = params.symbolize_keys.slice(:year, :month).transform_values(&:to_i)
    @event_date = DateTime.now.change date_params
    @events = Event.for_calendar(@event_date)
    @next_event = Event.next_event
    index!
  end
end
