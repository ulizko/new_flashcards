class FillJob < ApplicationJob
  queue_as :default

  def perform(user, options)
    data = Fill.start(options)
    data.each do |d|
      Card.create(d.merge(user: user))
    end
  end
end
