class UsersController < ApplicationController
  inherit_resources
  
  http_basic_authenticate_with name: ENV['HTTP_USER'], password: ENV['HTTP_PASSWORD'], except: [:index, :show]
  
  def index
    @users = User.order(:name)
    index! do |format|
      format.json { render json: @users.tokens(params[:q]) }
    end
  end
end
