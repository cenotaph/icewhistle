require 'rails_helper'

RSpec.describe Registration, type: :model do
  context 'with validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  it 'has a valid factory' do
    event = FactoryBot.create(:event)
    expect(FactoryBot.build(:registration, event: event).save).to be true
  end
end
