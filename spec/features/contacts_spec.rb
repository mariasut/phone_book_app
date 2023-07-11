require 'rails_helper'

RSpec.feature "Contacts", type: :feature do

  let!(:contact) { Contact.create(first_name: "Maria", last_name: "Sut", phone_number: 32323233) }

  scenario "Creating a new contact" do
    visit new_contact_path

    fill_in "First Name", with: "Maria", wait: 5
    fill_in "Last Name", with: "Sut"
    fill_in "Phone Number", with: 32323233
    click_button "Create Contact"

    expect(page).to have_content("Contact was successfully created.")
  end

  scenario "Viewing a contact" do

    visit contact_path(contact)
    expected_text = "Phone Book App\nMaria Sut\nPhone Number: 3-232-3233\nEdit Back to Contacts"
    expect(page.text).to match(/#{Regexp.escape(expected_text)}/)
  end

  scenario "Updating a contact" do

    visit edit_contact_path(contact)

    fill_in "First Name", with: "Updated"
    fill_in "Last Name", with: "Contact"
    click_button "Update Contact"

    expect(page).to have_content("Contact was successfully updated.")
    expect(page).to have_content("Updated Contact")
  end

  scenario "Listing all contacts" do
    contact2 = Contact.create(first_name: "Elena", last_name: "Sut", phone_number: 32323233)

    visit contacts_path

    expected_text = "Phone Book App\nContacts\nAdd Contact\nMaria Sut 3-232-3233\nElena Sut 3-232-3233"
    expect(page).to have_content(expected_text)
  end
end
