class FillJob < ApplicationJob
  queue_as :default

  def perform(options, user)
    data = Fill.start(options)
    data.each do |d|
      Card.create(v, user: user)
    end
  end
end
