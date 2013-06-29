class ServiceProvider
  class Enqueuer

    # CLASS METHODS

    def self.perform
      ServiceProvider.available.find_in_batches do |service_providers|
        service_providers.each do |service_provider|
          ServiceProvider::Enqueuer.enqueue(service_provider)
        end
      end
    end

    def self.enqueue(*args)
      new(*args).enqueue!
    end

    # INSTANCE METHODS

    def initialize(service_provider)
      @service_provider = service_provider
    end

    def enqueue!
      if has_upcoming_event?
        service_provider.enqueue!(next_event)
      end
    end

    private

    attr_reader :service_provider

    def has_upcoming_event?
      next_event.present?
    end

    def next_event
      @next_event ||= service_provider.next_event
    end

  end
end
