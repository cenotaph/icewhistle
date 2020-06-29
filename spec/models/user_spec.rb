require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  it 'has a valid factory' do
    expect(FactoryBot.build(:user).save).to be true
  end

end
