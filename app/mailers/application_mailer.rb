# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@serious-lunch.com'
  layout 'mailer'
end
