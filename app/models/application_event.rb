class ApplicationEvent < RailsEventStore::Event
  class Data
    include Virtus.model
    include ActiveModel::Validations
  end

  def initialize(event)
    super(event)
    self.class.const_get('Data').new(self.data).validate!
  end

  def self.subscribe(&block)
    EventStore.subscribe(block, [self])
  end

  def self.call(data)
    event = self.new(data: data)
    EventStore.publish_event(event)
  end

end
