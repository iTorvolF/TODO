# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name('no-reply@example.com', 'TODO-сайт')
  layout 'mailer'
end
