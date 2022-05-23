FactoryBot.define do
  factory :item do
    name { FFaker::HipsterIpsum.phrase }
    done { false }
    event { create(:event) }    
  end
end
