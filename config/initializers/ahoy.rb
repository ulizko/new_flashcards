class Ahoy::Store < Ahoy::Stores::ActiveRecordTokenStore
  # customize here
  def track_event(name, properties, options)
    super do |event|
      event.group = properties[:group]
      event.status = properties[:status]
      event.card_id = properties[:card_id] if event.respond_to?(:card_id=)
    end
  end
end
