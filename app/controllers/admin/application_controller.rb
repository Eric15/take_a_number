class Admin::ApplicationController < ApplicationController

  layout "admin"
  respond_to :html, :json

  before_filter :authenticate_admin_user!

end
