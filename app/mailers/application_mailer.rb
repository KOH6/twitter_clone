# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'Twitterクローン送信者'
  layout 'mailer'
end
