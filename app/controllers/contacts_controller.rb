class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    if @contact.create(contact_params)
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name,:email,:title,:content)
  end

end
