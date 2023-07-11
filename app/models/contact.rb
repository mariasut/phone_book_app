class Contact < ApplicationRecord
    validates :first_name, :last_name, :phone_number, presence: true
    validates :phone_number, numericality: true
    validates_format_of :phone_number, :with =>  /\d[0-9]\)*\z/ , :message => "Only positive number without spaces are allowed"

    def full_name
        "#{first_name} #{last_name}"
    end
end
