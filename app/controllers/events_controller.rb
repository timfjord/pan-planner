class EventsController < ApplicationController
  inherit_resources
  
  http_basic_authenticate_with name: "admin", password: "admin", except: :index
  
  def index
    @event_date = DateTime.now.change params.symbolize_keys.slice(:year, :month).transform_values(&:to_i)
    index!
  end
end
