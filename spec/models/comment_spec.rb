require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { build(:comment) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:commentable) }
  it { is_expected.to be_valid (:comment) }
end
