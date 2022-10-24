# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  active                 :boolean          default(TRUE)
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  done_counter           :integer          default(0)
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  events_count           :integer
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  name                   :string
#  not_done_counter       :integer          default(0)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  settings               :jsonb
#  sign_in_count          :integer          default(0), not null
#  state                  :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role_id                :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_name                  (name) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
FactoryBot.define do
  factory :user do
    sequence(:name) { |n| FFaker::Internet.user_name[0...10] + n.to_s }
    sequence(:email) { |n| "person#{n}@example.com" }
    active { true }
    role { create(:role) }
    password { '12345678' }
    password_confirmation { '12345678' }

    factory :admin do
      role { create(:role, name: 'Администратор', code: :admin) }
      after(:create) do |user|
        def user.admin?
          true
        end
      end
    end
  end
end
