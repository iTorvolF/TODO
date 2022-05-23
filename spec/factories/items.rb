# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { FFaker::HipsterIpsum.phrase }
    done { false }
    event { create(:event) }
  end
end
