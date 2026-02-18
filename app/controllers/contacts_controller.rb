class ContactsController < ApplicationController
  def new
    @contact = ContactForm.new
  end

  def create
    @contact = ContactForm.new(contact_params)

    if @contact.valid?
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to contact_path, notice: "お問い合わせを送信しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact_form).permit(:name, :email, :message)
  end
end
