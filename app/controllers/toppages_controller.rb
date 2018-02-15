class ToppagesController < ApplicationController
  def index
    if logged_in?
      redirect_to tasks_url
    end
  end
end
