# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :event

  validates :name, presence: true
end
