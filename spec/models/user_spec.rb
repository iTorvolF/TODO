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
require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(2) }
  it { is_expected.to validate_length_of(:name).is_at_most(50) }

  it { is_expected.to belong_to(:role) }
  it { is_expected.to have_many(:events).dependent(:destroy) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }

  it {
    expect(subject).to have_many(:commented_users)
      .through(:comments)
      .source(:commentable)
  }

  it {
    expect(subject).to have_many(:commented_events)
      .through(:comments)
      .source(:commentable)
  }
end
