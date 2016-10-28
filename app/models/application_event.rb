class ApplicationEvent < RailsEventStore::Event
  extend Forwardable

  def_delegator :@data_model, :validate!, :validate!

  class InvalidEventData < StandardError; end

  class Data
    include Virtus.model
    include ActiveModel::Validations
  end

  attr_accessor :data_model

  def initialize(event)
    self.data_model = self.class.const_get('Data').new(event[:data])
    event[:data] = data_model.to_h
    super(event)
  end

  def self.subscribe(&block)
    EventStore.subscribe(block, [self])
  end

  def self.call(data = {})
    ApplicationRecord.as_mutable do
      ActiveRecord::Base.transaction do
        self.new(data: data).tap do |event|
          event.validate!
          EventStore.publish_event(event)
        end
      end
    end
  end

end
