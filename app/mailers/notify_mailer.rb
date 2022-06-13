class NotifyMailer < ApplicationMailer
  def user_deadlines(user, events)
    @events = events
    mail(
      to: email_address_with_name(user.email, user.name),
      subject: I18n.t('emails.subjects.user_deadlines')
    )
  end
end