module Admin::LocationsHelper

  def service_providers
    @service_providers
  end

  def active_service_providers
    resource.service_providers
  end

  def service_provider_active?(service_provider)
    service_provider.location_id == resource.id
  end

  def started_event(sp)
    sp.started_event.try(:customer_name) || "None"
  end

  def enqueued_event(sp)
    sp.enqueued_event.try(:customer_name) || sp.next_scheduled_event.try(:customer_name) || "None"
  end

end
