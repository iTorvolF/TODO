namespace :deadline do
  desc "Рассылка писем об истечении сроков"
  task emails: :environment do
    deadline_events = Event.select{|event| event.finished_at < (Time.now + 1.day)}
                        .group_by{ |event| event.user_id }
    deadline_events.each do |user_id, event|
      user = User.find(user_id)
      NotifyMailer.user_deadlines(user, event).deliver_now if user.active
    end
  end
end