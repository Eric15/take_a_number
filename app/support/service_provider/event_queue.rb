class ServiceProvider
  class EventQueue

    # CLASS METHODS

    def self.for(*args)
      new(*args)
    end

    # INSTANCE METHODS

    def initialize(service_provider)
      @service_provider = service_provider
    end

    def next
      if interval.fits?
        next_unscheduled
      else
        next_scheduled
      end
    end

    def started
      service_provider.started_event
    end

    def enqueued
      service_provider.enqueued_event
    end

    def next_scheduled
      service_provider.scheduled_events.pending.first
    end

    def next_unscheduled
      service_provider.unscheduled_events.pending.first
    end

    def interval
      Interval.new(started, next_scheduled, next_unscheduled)
    end

    private

    attr_reader :service_provider

    class Interval
      def initialize(scheduled_a, scheduled_b, unscheduled)
        @start_time = scheduled_a.est_finished_at if scheduled_a
        @end_time   = scheduled_b.started_at      if scheduled_b
        @duration   = unscheduled.time_estimate   if unscheduled
      end

      def fits?
        start_time + duration <= end_time
      end

      private

      def start_time
        @start_time ||= Time.now
      end

      def end_time
        @end_time ||= start_time + 1.hour
      end

      def duration
        @duration ||= Event::TIME_ESTIMATE
      end
    end

  end
end
