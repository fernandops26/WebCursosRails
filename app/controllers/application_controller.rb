class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  rescue_from Exception, :with => :render_404
private

def render_404
render :template => 'errors/not_found', :layout => false, :status => :not_found
end


  protect_from_forgery with: :exception

  include UserSessionsHelper
end
