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
require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
