require 'cancan/matchers'
require 'rails_helper'
# ...
describe Ability do
  describe 'Listing' do
    subject(:ability) { Ability.new(user) }
    let(:user){ nil }

    context 'when is logged in' do
      let(:user){ FactoryBot.create(:user) }

      it { is_expected.to be_able_to(:create, Listing.new) }
      it { is_expected.to_not be_able_to(:update, Listing.new) }
      it { is_expected.to be_able_to(:update, FactoryBot.create(:listing, creator: user)) }
    end
  end
end