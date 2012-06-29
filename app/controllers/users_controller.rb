class UsersController < ApplicationController
  inherit_resources
  
  http_basic_authenticate_with name: "admin", password: "admin", except: :index
end
