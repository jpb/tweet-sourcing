class ApplicationEvent < RailsEventStore::Event

  def self.subscribe(&block)
    EventStore.subscribe(block, [self])
  end

  def self.call(data)
    event = self.new(data: data)
    EventStore.publish_event(event)
  end

end
