# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  def complete(notification:)
    @notification = notification
    recipient = @notification.user.email
    mail(to: recipient, subject: 'Twitterクローン通知')
  end
end
