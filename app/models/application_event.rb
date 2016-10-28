class ApplicationEvent < RailsEventStore::Event
  class Data
    include Virtus.model
    include ActiveModel::Validations
  end

  def initialize(event)
    data = self.class.const_get('Data').new(event[:data])
    data.validate!
    event[:data] = data.to_h
    super(event)
  end

  def self.subscribe(&block)
    EventStore.subscribe(block, [self])
  end

  def self.call(data)
    ActiveRecord::Base.transaction do
      event = self.new(data: data)
      EventStore.publish_event(event)
    end
  end

end
