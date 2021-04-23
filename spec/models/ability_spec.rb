require 'cancan/matchers'
require 'rails_helper'
# ...
describe Ability do
  describe 'Listing' do
    subject(:ability) { Ability.new(user) }
    let(:user){ nil }

    context 'when is logged in' do
      let(:user){ FactoryBot.create(:user) }
      let(:owned_listing){ FactoryBot.create(:listing, creator: user) }

      it { is_expected.to be_able_to(:create, Listing.new) }
      it { is_expected.to_not be_able_to(:update, Listing.new) }
      it { is_expected.to be_able_to(:update, owned_listing) }

      it { is_expected.to be_able_to(:create, Conversation.new) }
      it { is_expected.to_not be_able_to(:create, FactoryBot.create(:conversation, listing: owned_listing)) }
    end
  end
end