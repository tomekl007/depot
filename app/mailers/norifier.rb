class Norifier < ActionMailer::Base
  default from: "Tomek Lelek depot@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.norifier.order_received.subject
  #
  def order_received(order)
    @order = order
    @greeting = "Hi"
    logger.info "order_received to #{order.email}"
    mail to: @order.email, :subject => 'pragma store order confirmation'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.norifier.order_chipped.subject
  #
  def order_chipped(order)
    @greeting = "Hi"
    @order = order
    logger.info "order_shipped to #{order.email}"
    mail to: @order.email, :subject => 'pragma store order shipped'
  end


  @admin_email = 'tomekl007@gmail.com'
  def send_error_to_admin(msg)
  @msg = msg
  logger.info @msg
  mail to: 'tomekl007@gmail.com', :subject => "Depot App Error Incident"
  end

end
