# frozen_string_literal: true

class Item < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 50, minimum: 2 }
end
