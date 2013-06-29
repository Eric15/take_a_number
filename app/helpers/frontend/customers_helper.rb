module Frontend::CustomersHelper

  def service_providers
    @service_providers
  end

  def service_provider_options
    options = [ [ "First Available", Event::FIRST_AVAILABLE ] ]
    service_providers.each {|sp| options << [ sp.full_name, sp.id ] }
    options_for_select(options)
  end

end
