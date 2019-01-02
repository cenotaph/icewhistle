require 'rails_helper'

RSpec.describe Event, type: :model do
  context 'with validations' do
    it { is_expected.to validate_presence_of(:start_at) }
    it { is_expected.to validate_presence_of(:end_at) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
  end

  it 'has a valid factory' do
    expect(FactoryBot.build(:event).save).to be true
  end

end
