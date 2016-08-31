class AdminsController < ApplicationController
 layout 'admin'
 before_filter :authenticate_user, :validate_admin

  def index
  end
end
