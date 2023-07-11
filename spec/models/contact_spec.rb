require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validations' do
    let(:contact) { Contact.new(first_name: 'Maria', last_name: 'Sut', phone_number: 1234567890) }

    it 'is valid with valid attributes' do
      expect(contact).to be_valid
    end

    it 'is not valid without a first name' do
      contact.first_name = nil
      expect(contact.valid?).to be_falsey
    end

    it 'is not valid without a last name' do
      contact.last_name = nil
      expect(contact.valid?).to be_falsey
    end

    it 'is not valid without a phone number' do
      contact.phone_number = nil
      expect(contact.valid?).to be_falsey
    end

    it 'is not valid phone number with letters' do
      contact.phone_number = '232334L'
      expect(contact.valid?).to be_falsey
    end

    context '#full_name' do
      it { expect(contact.full_name).to eq('Maria Sut')}
    end
  end
end


