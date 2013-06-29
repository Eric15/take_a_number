class AdminUser < ActiveRecord::Base

  # INCLUSIONS

  include BelongsToTenant

  # SCOPES

  default_scope { current_tenant }

  # ATTRIBUTES

  devise :database_authenticatable, :rememberable, :validatable

end
