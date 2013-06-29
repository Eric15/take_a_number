class ServiceProvider < ActiveRecord::Base

  # INCLUSIONS

  include FullName
  include BelongsToTenant

  # SCOPES

  default_scope { current_tenant }

  scope :available, lambda { where(enqueued_event_id: nil) }

  # ASSOCIATIONS

  belongs_to :enqueued_event, class_name: "Event"
  belongs_to :started_event,  class_name: "Event"

  # VALIDATIONS

  validates :first_name, :last_name, presence: true

  # INSTANCE METHODS

  def events
    Event.requesting(id).readonly(false)
  end

  def scheduled_events
    events.scheduled
  end

  def unscheduled_events
    events.unscheduled
  end

  def number_waiting
    events.pending.count
  end

  def active?
    location_id.present?
  end

  def activate!(location_id)
    update_attributes(location_id: location_id)
  end

  def deactivate!
    update_attributes(location_id: nil)
  end

  def dequeue!
    next_event.reset! do
      update_attributes(enqueued_event: nil)
    end
  end

  def enqueue!(event)
    if active?
      event.enqueue! do
        update_attributes(enqueued_event: event)
      end
    end
  end

  def finish!
    started_event && started_event.finish!
    update_attributes(started_event: enqueued_event, enqueued_event: nil)
    started_event && started_event.start!
    Enqueuer.enqueue(self)

    true
  end

  def next_unscheduled_event
    unscheduled_events.pending.first
  end

  def next_scheduled_event
    scheduled_events.pending.first
  end

  def next_event
    event_queue.next
  end

  def event_queue
    EventQueue.for(self)
  end

end
