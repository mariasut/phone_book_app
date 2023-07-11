class ContactsController < ApplicationController
  before_action :set_contact, only: %w[show edit update destroy]

  def index
    @contacts = Contact.all
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to contact_path(@contact), notice: 'Contact was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      redirect_to contact_path(@contact), notice: 'Contact was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
      if @contact.destroy
        redirect_to contacts_path, notice: 'Contact was successfully deleted.'
      else
        redirect_to contacts_path, warning: 'Contact could not be deleted.'
      end
    end
  
  def search
      @contacts = Contact.where("last_name ilike ?", "%#{params[:q]}%")
      render '/contacts/contact_list', layout: false
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end
  
  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :phone_number)
  end
end
