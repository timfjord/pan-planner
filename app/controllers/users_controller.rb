class UsersController < ApplicationController
  inherit_resources
  
  http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show]
  
  def index
    @users = User.order(:name)
    index! do |format|
      format.json { render json: @users.tokens(params[:q]) }
    end
  end
end
