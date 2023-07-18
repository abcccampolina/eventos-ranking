namespace :database do
  desc "Offline Event - Synchronization of production database to local database development2"
  task sync: :environment do
    DatabaseSync.new.perform
  end

  desc "Clear database Event - Synchronization of production database to local database development2"
  task clear: :environment do
    DatabaseSync.new.clear
  end
end
