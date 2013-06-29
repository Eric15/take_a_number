module Admin::ScheduledEventsHelper

  def customers
    @customers
  end

  def customer_options
    options_for_select customers.map {|c| [c.full_name, c.id] }
  end

  def scheduled_event_service_provider_options
    options = service_providers.map {|sp| [ sp.full_name, sp.id ] }
    options_for_select(options)
  end

end
