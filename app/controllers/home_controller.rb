class HomeController < ActionController::Base
  def landing
    render layout: 'home'
  end
end
