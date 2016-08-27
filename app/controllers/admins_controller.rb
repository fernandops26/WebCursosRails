class AdminsController < ApplicationController
before_filter :authenticate_user, :validate_admin

  def index
  end
end
