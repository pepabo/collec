class SlackMessageWorker
  include Sidekiq::Worker
  sidekiq_options queue: :slack, retry: 5
  def perform(message)
    # slackにメッセージを送る
    Dummy.new.send
  end
end

# slackの実装が終わったら消してください
class Dummy
  def send; end
end
