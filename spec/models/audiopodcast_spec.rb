require 'rails_helper'

RSpec.describe Audiopodcast, :type => :model do
  context 'with validations' do
    it { is_expected.to validate_presence_of(:url) }
  end
end
