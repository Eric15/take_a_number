class Message < ActiveRecord::Base

  # INCLUSIONS

  include BelongsToTenant

  # SCOPES

  default_scope { current_tenant }

  # ASSOCIATIONS

  belongs_to :customer

  # VALIDATIONS
 
  validates :customer_id, :body, presence: true

  # INSTANCE_METHODS

  def to
    customer.phone
  end

end
