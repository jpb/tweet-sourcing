class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  alias_method :original_save!, :save!

  def save!
    # !!! Should only be changed by an ApplicationEvent !!!
    if Thread.current[:application_record_mutable]
      original_save!
    else
      raise "Oh no you don't!"
    end
  end

  # !!! Should only be called by an ApplicationEvent !!!
  def self.as_mutable
    previous = Thread.current[:application_record_mutable]
    Thread.current[:application_record_mutable] = true
    yield
  ensure
    Thread.current[:application_record_mutable] = previous
  end

end
