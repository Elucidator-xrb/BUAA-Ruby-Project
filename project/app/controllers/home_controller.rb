class HomeController < ApplicationController
  before_action :authenticate_manipulator!

  def index
  end

  # post 
  def authorize
    if params[:verification_code] == "114514"
      @manipulator = Manipulator.where(:id => current_manipulator.id).update(:mtype => 0)
      redirect_to home_index_path
    end
  end
end
