require 'rails_helper'

RSpec.describe EventPolicy do
  subject { described_class.new(user, event) }

  context 'пользователь не авторизован' do
    let(:event) { create(:event) }
    let(:user) { nil }

    it { is_expected.not_to permit(:index) }
    it { is_expected.not_to permit(:new) }
    it { is_expected.not_to permit(:show) }
    it { is_expected.not_to permit(:create) }
    it { is_expected.not_to permit(:update) }
    it { is_expected.not_to permit(:edit) }
    it { is_expected.not_to permit(:destroy) }
  end

  context 'пользователь авторизован' do
    let(:event) { create(:event, user: user) }
    let(:user) { create(:user) }

    it { is_expected.to permit(:index) }
    it { is_expected.to permit(:new) }
    it { is_expected.to permit(:show) }
    it { is_expected.to permit(:create) }
    it { is_expected.to permit(:update) }
    it { is_expected.to permit(:edit) }
    it { is_expected.to permit(:destroy) }
  end

  context 'пользователь администратор' do
    before { create(:role, code: :admin) }

    let(:event) { create(:event, user: user) }
    let(:user) { create(:user, role: build(:role, code: :admin)) }

    it { is_expected.to permit(:index) }
    it { is_expected.to permit(:new) }
    it { is_expected.to permit(:show) }
    it { is_expected.to permit(:create) }
    it { is_expected.to permit(:update) }
    it { is_expected.to permit(:edit) }
    it { is_expected.to permit(:destroy) }
  end
end
