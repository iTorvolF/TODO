# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  subject { build(:role) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_many(:users) }
  it { is_expected.to be_valid(:role) }
end
