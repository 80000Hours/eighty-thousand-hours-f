require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  def authorize_admin!
    authenticate_user!
    raise CanCan::AccessDenied unless can? :access, :admin
  end

  def after_sign_in_path_for(resource)
    if current_user.sign_in_count <= 1
      #assume the user has just signed up so redirect to edit profile
      redirect_to( etkh_profile_path( current_user ) )
    else
      #assume user is simply logging in and treat as normal
      if session[:user_return_to] == root_path
        dashboard_path
      else
        session[:user_return_to] || root_path
      end
    end
  end

  protected
  # For Google Analytics event tracking from within controllers
  # http://stackoverflow.com/questions/9283763/how-do-i-use-google-analytics-custom-events-inside-my-rails-controller
  #
  # Calling this from a controller will add to the list of 'events' to be
  # added to the Google Analytics queue. This will be executed on the first
  # page render (shared/_google_analytics_events.html.erb).
  def log_event(category, action, label = nil, value = nil)
    session[:events] ||= Array.new
    session[:events] << {:category => category, :action => action, :label => label, :value => value}
  end
end
