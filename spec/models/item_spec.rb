# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id          :bigint           not null, primary key
#  done        :boolean          default(FALSE)
#  finished_at :datetime
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  event_id    :bigint
#
# Indexes
#
#  index_items_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#
require 'rails_helper'

RSpec.describe Item, type: :model do
  subject { build(:item) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to belong_to(:event) }
  it { is_expected.to be_valid(:item) }
end
