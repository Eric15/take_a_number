namespace :schedule do

  task perform: :environment do
    ServiceProvider::Enqueuer.perform
  end

end
