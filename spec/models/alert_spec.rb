require 'spec_helper'

describe Alert do
  describe 'associations' do
    it { should belong_to(:event) }
  end

  describe 'validations' do
    it { should validate_presence_of(:type) }
  end

  describe 'attributes' do
    it { should_not allow_mass_assignment_of(:type) }
    it { should have_readonly_attribute(:uuid) }
  end

  describe '#notify' do
    it do
      expect { Alert.new.notify }.to raise_error(StandardError, "#notify must be overridden in a subclass")
    end
  end

end
