module Frontend::UnscheduledEventsHelper

  def service_providers
    @service_providers || []
  end

  def request_options
    options = [ ["First Available", "all"] ]
    service_providers.each {|sp| options << [sp.full_name, sp.id] }
    options_for_select options
  end

end
