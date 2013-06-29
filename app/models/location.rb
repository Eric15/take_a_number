class Location < ActiveRecord::Base

  # INCLUSIONS

  include BelongsToTenant

  # SCOPES

  default_scope { current_tenant }

  scope :open,   lambda { where(open: true) }
  scope :closed, lambda { where(open: false) }

  # ASSOCIATIONS

  has_many :service_providers

  # INSTANCE METHODS

  def open!
    update_attributes(open: true)
  end

  def close!
    update_attributes(open: false)
  end

end
