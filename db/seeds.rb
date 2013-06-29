tenants = []
tenant_attributes = [
  { subdomain: "bolt" }
]

puts "CREATING TENANTS"
tenant_attributes.each do |attributes|
  tenants << Tenant.create!(attributes)
end

tenants.each do |tenant|

  puts " * FOR TENANT ##{tenant.id}"

  tenant.current!

  admin_users = []
  admin_user_attributes = [
    { email: "admin@example.com", password: "password", password_confirmation: "password" } 
  ]

  puts "  - CREATING ADMIN USERS"
  admin_user_attributes.each do |attributes|
    admin_users << AdminUser.create!(attributes)
  end

  locations = []
  location_attributes = [
    { name: "Foo", address: "123 Foo St" },
    { name: "Bar", address: "456 Bar St" }
  ]

  puts "  - CREATING LOCATIONS"
  location_attributes.each do |attributes|
    locations << Location.create!(attributes)
  end

  customers = []
  customer_attributes = [
    { first_name: "John",   last_name: "Doe",   phone: "2069159141" },
    { first_name: "John-1", last_name: "Doe-1", phone: "2069159141" },
    { first_name: "John-2", last_name: "Doe-2", phone: "2069159141" },
    { first_name: "John-3", last_name: "Doe-3", phone: "2069159141" },
    { first_name: "John-4", last_name: "Doe-4", phone: "2069159141" },
    { first_name: "John-5", last_name: "Doe-5", phone: "2069159141" },
    { first_name: "John-6", last_name: "Doe-6", phone: "2069159141" },
    { first_name: "John-7", last_name: "Doe-7", phone: "2069159141" },
    { first_name: "John-8", last_name: "Doe-8", phone: "2069159141" },
    { first_name: "John-9", last_name: "Doe-9", phone: "2069159141" }
  ]

  puts "  - CREATING CUSTOMERS"
  customer_attributes.each do |attributes|
    customers << Customer.create!(attributes)
  end

  events = []
  puts "  - CREATING EVENTS"
  customers.each_with_index do |customer, i|
    if i % 2 == 0 
      events << customer.scheduled_events.create!(started_at: Time.now + i * 20.minutes)
    else
      events << customer.unscheduled_events.create!
    end
  end

  service_providers = []
  service_provider_attributes = [
    { first_name: "Jane",   last_name: "Doe" },
    { first_name: "Jane-1", last_name: "Doe-1" },
    { first_name: "Jane-2", last_name: "Doe-2" },
    { first_name: "Jane-3", last_name: "Doe-3" },
    { first_name: "Jane-4", last_name: "Doe-4" }
  ]

  puts "  - CREATING SERVICE PROVIDERS"
  service_provider_attributes.each do |attributes|
    service_providers << locations.sample.service_providers.create!(attributes)
  end

  puts "  - CREATING SERVICE PROVIDER REQUESTS"
  events.each do |event|
    event.requested = (0..3).map { service_providers.sample.id }
    event.save
  end
end
