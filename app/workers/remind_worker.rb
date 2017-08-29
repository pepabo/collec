class RemindWorker
  include Sidekiq::Worker
  sidekiq_options queue: :remind, retry: 5
  def perform(mention_id)
    response = Slack::MessageButton.new.disable_previous_message(mention_id)

    SlackMessageWorker.perform_async mention_id

    response
  end
end
