# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  content     :text
#  done        :boolean          default(FALSE)
#  finished_at :datetime
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_events_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Event, type: :model do
  subject { build(:event) }

  context 'в невалидном состоянии' do
    let(:event) { build(:event_wrong) }

    it 'когда пустое название' do
      expect(event).not_to be_valid
      error_message = 'Название обязательно для заполнения'
      expect(event.errors.full_messages).to include error_message
    end

    it 'когда отсутствует владелец' do
      expect(event).not_to be_valid
      error_message = 'Пользователь не может отсутствовать'
      expect(event.errors.full_messages).to include error_message
    end
  end


  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to respond_to(:user) }
  it { is_expected.to have_many(:items).dependent(:destroy) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }
  it { is_expected.to be_valid(:event) }
  it { is_expected.to belong_to(:user).counter_cache(true) }
end
