# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  content     :text
#  finished_at :datetime
#  name        :string
#  state       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_events_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :event do
    name { FFaker::HipsterIpsum.phrase }
    content { FFaker::HipsterIpsum.paragraphs }
    done { false }
    user { create(:user) }
  end
end
