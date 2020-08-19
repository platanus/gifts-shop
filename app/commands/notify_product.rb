class NotifyProduct < PowerTypes::Command.new(:product)
  def perform
    message_body = "ID: #{@product.id}, #{@product.name} "\
                   "de #{@product.store.name} "\
                   "a $#{@product.price}"
    slack.notify(
      "Nuevo producto!: "\
      "#{message_body}"
    )
  end

  private

  def slack
    @slack ||= SlackService.new
  end
end
