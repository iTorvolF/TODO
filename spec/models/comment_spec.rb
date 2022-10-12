# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  children_count   :integer          default(0), not null
#  commentable_type :string
#  content          :text
#  depth            :integer          default(0), not null
#  lft              :integer          not null
#  rgt              :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :bigint
#  parent_id        :integer
#  user_id          :bigint
#
# Indexes
#
#  index_comments_on_commentable  (commentable_type,commentable_id)
#  index_comments_on_parent_id    (parent_id)
#  index_comments_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { build(:comment) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:commentable) }
  # it { is_expected.to be_valid(:comment) }
  # it { is_expected.to belong_to(:parent) }
  it { is_expected.to have_many(:children) }
end
