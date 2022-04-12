# frozen_string_literal: true

class Event < ApplicationRecord
  validates :name, length: { maximum: 50, minimum: 3 }
  validates :content, length: { maximum: 500, minimum: 2 }
  validates :content, :name, presence: true
end
