# frozen_string_literal: true

class NotifyMailerPreview < ActionMailer::Preview
  def user_deadlines
    user = User.first
    NotifyMailer.user_deadlines(user, user.events)
  end
end
