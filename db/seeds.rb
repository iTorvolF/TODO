# frozen_string_literal: true

Item.destroy_all
Event.destroy_all
User.destroy_all
Role.destroy_all
Comment.destroy_all

default_role = Role.create!(name: 'Пользователь', code: :default)
admin_role = Role.create!(name: 'Администратор', code: :admin)

admin_email = 'admin@example.com'
User.create! name: 'Администратор',
             email: admin_email,
             password: admin_email,
             role: admin_role

hash_users = 10.times.map do
  email = FFaker::Internet.safe_email
  {
    name: FFaker::Internet.user_name[0...16],
    email: email,
    password: email,
    role: default_role
  }
end

users = User.create! hash_users

hash_events = 20.times.map do
  {
    name: FFaker::HipsterIpsum.paragraph,
    content: FFaker::HipsterIpsum.paragraphs,
    finished_at: (Time.now + rand(1..15).day),
    user: users.sample
  }
end

events = Event.create! hash_events
hash_items = 200.times.map do
  {
    name: FFaker::HipsterIpsum.paragraph,
    event: events.sample
  }
end
Item.create! hash_items

hash_comments = 200.times.map do
  commentable = (rand(2) == 1 ? events : users).sample
  {
    content: FFaker::HipsterIpsum.paragraphs,
    user: users.sample,
    commentable_id: commentable.id,
    commentable_type: commentable.class.to_s
  }
end
# Comment.create! hash_comments
# if Rails.env.development?
#   AdminUser.create!(email: 'admin@example.com', password: 'password',
#                     password_confirmation: 'password')
# end
