class NotifyFeedback < PowerTypes::Command.new(:feedback)
  GROUP_ID = ENV.fetch('TELEGRAM_GROUP_ID')
  TELEGRAM_TOKEN = ENV.fetch('BOT_TOKEN')
  def perform
    uri = URI("https://api.telegram.org/bot#{TELEGRAM_TOKEN}/sendMessage")
    Net::HTTP.post_form(uri, chat_id: GROUP_ID, text: text)
  rescue Errno::ECONNREFUSED, JSON::ParserError
    false
  end

  private

  def contact_info(giver)
    return false if !giver.email && !giver.phone_number

    info = ["Contact info:"]
    info.push("\tEmail: #{giver.email}") if giver.email
    info.push("\tPhone Number: #{giver.phone_number}") if giver.phone_number
    info.join("\n")
  end

  def additional_info
    "Additional info: #{@feedback.additional_info}" if @feedback.additional_info
  end

  def text
    receiver = @feedback.receiver
    giver = receiver.giver
    message = ["Feedback #{@feedback.id}:"]
    message.push("Giver #{giver.id} needs help with a gift for '#{receiver.name}'(#{receiver.id})")
    message.push(additional_info) if additional_info
    message.push(contact_info(giver)) if contact_info(giver)
    message.join("\n")
  end
end
