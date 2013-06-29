class ApplicationController < ActionController::Base

  protect_from_forgery
  around_filter :scope_current_tenant

  private

  def current_tenant
    Tenant.find_by_subdomain! "bolt" #request.subdomain
  end
  helper_method :current_tenant

  def scope_current_tenant
    Tenant.current_id = current_tenant.id
    yield
  ensure
    Tenant.current_id = nil
  end

  def after_sign_in_path_for(resource_or_scope)
    admin_root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_admin_user_session_path
  end

end
