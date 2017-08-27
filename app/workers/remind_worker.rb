class RemindWorker
  include Sidekiq::Worker
  sidekiq_options queue: :remind, retry: 5
  def perform(mention_id)
    Dummy.new.send
  end
end

class Dummy
  def send; end
end
