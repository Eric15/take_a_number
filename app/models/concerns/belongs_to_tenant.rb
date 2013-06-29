module BelongsToTenant
  extend ActiveSupport::Concern

  def self.included(base)
    base.class_eval do
      scope :current_tenant, lambda { where(tenant_id: Tenant.current_id) }
    end
  end

end
