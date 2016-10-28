Rails.application.reloader.to_prepare do
  # Clear all subscriptions when reloading
  EventStore = RailsEventStore::Client.new

  EventStore.subscribe_to_all_events(
    -> (event) { Rails.logger.info("#{event.class.to_s} published. Data: #{event.data.inspect}") }
  )
end
