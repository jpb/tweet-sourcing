EventStore = RailsEventStore::Client.new

Rails.application.reloader.to_prepare do
  EventStore = RailsEventStore::Client.new
end
