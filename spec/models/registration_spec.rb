require 'rails_helper'

RSpec.describe Registration, type: :model do
  context 'with validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end

  it 'has a valid factory' do
    event = FactoryBot.create(:event)
    expect(FactoryBot.build(:registration, event: event).save).to be true
  end
end
