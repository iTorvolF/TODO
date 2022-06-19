# frozen_string_literal: true

namespace :deadline do
  desc 'Рассылка писем об истечении сроков'
  task emails: :environment do
    deadline_events = Event.where(finished_at: DateTime.now..(DateTime.now + 1.day), done: false)
                           .group_by(&:user_id)
    deadline_events.each do |user_id, event|
      user = User.find(user_id)
      NotifyMailer.user_deadlines(user, event).deliver_now if user.active
    end
  end
end
