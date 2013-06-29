class Customer < ActiveRecord::Base

  # INCLUSIONS

  include FullName
  include BelongsToTenant

  # SCOPES

  default_scope { current_tenant }

  # ASSOCIATIONS

  has_many :events, dependent: :destroy
  has_many :scheduled_events,
    class_name: "ScheduledEvent"
  has_many :unscheduled_events,
    class_name: "UnscheduledEvent"

  # VALIDATIONS

  validates :first_name, :last_name, presence: true

  # ATTRIBUTES

  accepts_nested_attributes_for :unscheduled_events

  # INSTANCE METHODS

  def summon!
    Summoner.summon(self) if can_summon?
  end

  private

  def can_summon?
    phone.present?
  end

end
