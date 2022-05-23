# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :items, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :commentators, through: :comments, source: :user

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
