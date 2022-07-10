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
  include AASM

  belongs_to :user, counter_cache: true
  has_many :items, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :commentators, through: :comments, source: :user
  has_many_attached :files, strict_loading: true

  validates :name, presence: true

  after_create :done_events, -> { user.increment!(done? ? :done_counter : :not_done_counter) }

  enum state: {
    created: 0,
    in_progress: 10,
    pending: 20,
    closed: 30
  }

  aasm column: 'state' do
    state :created, initial: true, display: I18n.t('state.created')
    state :in_progress, display: I18n.t('state.in_progress')
    state :pending, display: I18n.t('state.pending')
    state :closed, display: I18n.t('state.closed')

    event :create do
      transitions from: %i[created pending], to: :in_progress
    end

    event :process do
      transitions from: %i[in_progress created], to: :pending
    end

    event :finished do
      transitions from: :in_progress, to: :closed
    end
  end

  private

  def done_events
    user.increment!(done? ? :done_counter : :not_done_counter)
  end

  def not_done_events
    user.decrement!(done? ? :done_counter : :not_done_counter)
  end
end
