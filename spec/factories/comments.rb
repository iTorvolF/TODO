FactoryBot.define do
  factory :comment do
    content { FFaker::HipsterIpsum.paragraphs }
    user { create(:user) }
    association :commentable, factory: :user
  end
end
