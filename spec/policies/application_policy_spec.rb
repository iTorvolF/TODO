# RSpec.describe ApplicationPolicy do
#   subject { described_class.new(user, event) }

#   context 'пользователь не авторизован' do
#     let(:event) { create(:event) }
#     let(:user) { create(:user) }

#     it { is_expected.not_to permit(:index) }
#     it { is_expected.not_to permit(:show) }
#     it { is_expected.to permit(:new) }
#     it { is_expected.to permit(:create) }
#     it { is_expected.not_to permit(:update) }
#     it { is_expected.not_to permit(:edit) }
#     it { is_expected.not_to permit(:destroy) }
#   end
# end  
 