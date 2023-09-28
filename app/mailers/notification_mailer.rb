class NotificationMailer < ApplicationMailer
  def complete(notification:)
    @notification = notification
    mail(to: @notification.user.email, subject: 'Twitterクローン通知')
  end
end
