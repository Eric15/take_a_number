class Event < ActiveRecord::Base

  # INCLUSIONS

  include BelongsToTenant

  # CONSTANTS

  FIRST_AVAILABLE = -1

  TIME_ESTIMATE = 20.minutes
  SUMMON_PERIOD = 20.minutes

  PENDING   = "pending"
  ENQUEUED  = "enqueued"
  DELAYED   = "delayed"
  STARTED   = "started"
  FINISHED  = "finished"
  DEFAULT   = PENDING

  # SCOPES

  default_scope { current_tenant }

  scope :scheduled,   lambda { where(type: ScheduledEvent.name) }
  scope :unscheduled, lambda { where(type: UnscheduledEvent.name) }

  scope :pending,  lambda { where(state: PENDING) }
  scope :enqueud,  lambda { where(state: ENQUEUD) }
  scope :started,  lambda { where(state: STARTED) }
  scope :finished, lambda { where(state: FINISHED) }

  scope :requesting, lambda {|id|
    where("('?' = ANY(requested)) OR ('?' = ANY(requested))", FIRST_AVAILABLE, id)
  }

  # ASSOCIATIONS

  belongs_to :customer
  has_one :enqueued_on,
    foreign_key: "next_event_id",
    class_name: "ServiceProvider"

  # INSTANCE METHODS

  def customer_name
    customer.full_name
  end

  def est_finished_at
    started_at + time_estimate
  end

  def time_estimate
    TIME_ESTIMATE
  end

  def reset!(&block)
    if update_attributes(state: DEFAULT)
      block.call if block_given?
    end
  end

  def enqueue!(&block)
    if update_attributes(state: ENQUEUED, enqueued_at: Time.now)
      block.call if block_given?
    end
  end

  def delay!(&block)
    if update_attributes(state: DELAYED, delayed_at: Time.now)
      block.call if block_given?
    end
  end

  def start!(&block)
    if update_attributes(state: STARTED, started_at: Time.now)
      block.call if block_given?
    end
  end

  def finish!(&block)
    if update_attributes(state: FINISHED, finished_at: Time.now)
      block.call if block_given?
    end
  end

  def dequeue!
    if enqueued_on
      enqueued_on.dequeue!
    end
  end

  def pending?
    state == PENDING
  end

  def enqueued?
    state == ENQUEUED
  end

  def delayed?
    state == DELAYED
  end

  def started?
    state == STARTED
  end

  def finished?
    state == FINISHED
  end
  
end
