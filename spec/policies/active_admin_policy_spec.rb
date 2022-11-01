RSpec.describe ActiveAdmin::ApplicationPolicy do
  subject { described_class.new(user, event) }

  context 'пользователь не авторизован' do
    let(:event) { create(:event) }
    let(:user) { create(:admin) }

    it { is_expected.to permit(:report) }
    it { is_expected.to permit(:download) }
    it { is_expected.to permit(:upload) }
    it { is_expected.to permit(:excel) }
    it { is_expected.to permit(:index) }
    it { is_expected.to permit(:show) }
    it { is_expected.to permit(:read) }
    it { is_expected.to permit(:create) }
    it { is_expected.to permit(:update) }
    it { is_expected.to permit(:destroy) }
  end
end   