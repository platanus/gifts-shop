class SlackService
  CHANNEL_ID = ENV.fetch('SLACK_CHANNEL_ID')

  def initialize
    Slack.configure do |config|
      config.token = ENV.fetch('SLACK_API_TOKEN')
    end
  end

  def notify(message)
    if CHANNEL_ID != ""
      client.chat_postMessage(channel: CHANNEL_ID, text: message, as_user: true)
    end
  end

  private

  def client
    @client ||= Slack::Web::Client.new
  end
end
