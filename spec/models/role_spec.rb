# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  name       :string
#  code       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Role, type: :model do
  subject { build(:role) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_many(:users) }
  it { is_expected.to be_valid(:role) }
end
