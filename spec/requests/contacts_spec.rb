require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe "Contacts", type: :request do

  let!(:contacts) do
    [
      contact1 = Contact.create(first_name: 'Maria', last_name: 'Sut', phone_number: 343434343),
      contact2 = Contact.create(first_name: 'Maya', last_name: 'Cobut', phone_number: 3434332233),
      contact3 = Contact.create(first_name: 'Chris', last_name: 'Pop', phone_number: 454545667)
    ]
  end
  

  let(:contact_params) do
    { contact: { first_name: 'Elena', last_name: 'Smith', phone_number: 343434343 } }
  end

  let!(:contact) do
    Contact.create(contact_params[:contact])
  end

  describe "GET /contacts" do
    it 'returns all contacts' do
      get "/contacts"

      contact1, contact2, contact3 = contacts
      expect(response).to have_http_status(:success)
      expect(response.body).to include(contact1.last_name)
      expect(response.body).to include(contact2.last_name)
      expect(response.body).to include(contact3.last_name)
    end
  end

  describe "GET /contacts/:id" do
    it 'returns a specific contact' do

      get "/contacts/#{contact.id}"

      expect(response).to have_http_status(:success)
      expect(response.body).to include(contact.first_name)
      expect(response.body).to include(contact.last_name)
      expect(response.body).to include(number_to_phone(contact.phone_number, :groupings => [3, 3, 4], :delimiter => "-"))
      
    end
  end

  describe "POST /contacts" do
    it 'creates a new contact' do
      post "/contacts", params: contact_params

      expect(response).to have_http_status(:found)
      follow_redirect!
      expect(response).to have_http_status(:success)
      expect(Contact.last.first_name).to eq('Elena')
      expect(Contact.last.last_name).to eq('Smith')
      expect(Contact.last.phone_number).to eq('343434343')
    end
  end

  describe "PATCH /contacts/:id" do
    it 'updates an existing contact' do
      updated_params = { contact: { first_name: 'Updated', last_name: 'Contact' } }

      patch "/contacts/#{contact.id}", params: updated_params
      expect(response).to have_http_status(:found)
      follow_redirect!
      expect(response).to have_http_status(:ok)
      expect(contact.reload.first_name).to eq('Updated')
      expect(contact.reload.last_name).to eq('Contact')
    end
  end

  describe "DELETE /contacts/:id" do
    it 'deletes an existing contact' do
      delete "/contacts/#{contact.id}"
      expect(response).to have_http_status(:found)
      follow_redirect!

      expect(response).to have_http_status(:ok)
      expect(Contact.find_by(id: contact.id)).to be_nil
    end
  end

  describe "GET /contacts/search" do
    it 'returns filtered contacts based on last name' do
      get "/contacts/search", params: { q: 'Sut' }

      contact1, contact2, contact3 = contacts

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('text/html; charset=utf-8')
      expect(response.body).to include(contact1.last_name)
      expect(response.body).not_to include(contact2.last_name)
      expect(response.body).not_to include(contact3.last_name)
    end
  end
end
