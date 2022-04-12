# frozen_string_literal: true

class Role < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 50, minimum: 2 }
  validates :name, uniqueness: true
end
