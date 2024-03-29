# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  content     :text
#  done        :boolean          default(FALSE)
#  finished_at :datetime
#  name        :string
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
class Event < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :items, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :commentators, through: :comments, source: :user
  has_many_attached :files # strict_loading: true

  validates :name, presence: true

  after_create :done_events, -> { user.increment!(done? ? :done_counter : :not_done_counter) }

  private

  def done_events
    user.increment!(done? ? :done_counter : :not_done_counter)
  end

  def not_done_events
    user.decrement!(done? ? :done_counter : :not_done_counter)
  end
end
