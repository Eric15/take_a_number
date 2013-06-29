class Tenant < ActiveRecord::Base

  # VALIDATIONS
  
  validates :subdomain, presence: true
  validates :subdomain, uniqueness: true

  # CLASS METHODS

  def self.current_id=(id)
    Thread.current[:tenant_id] = id
  end

  def self.current_id
    Thread.current[:tenant_id]
  end

  def self.current
    Thread.find(current_id)
  end

  # INSTANCE METHODS

  def current!
    self.class.current_id = id
    self
  end

end
