class Event
  class Dequeuer

    # CLASS METHODS

    def self.dequeue(*args)
      new(*args).dequeue!
    end

    # INSTANCE METHODS

    def initialize(event)
      @event = event
    end

    def dequeue!
      event.dequeue! if event.enqueued?
    end

    private

    attr_reader :event

  end
end
