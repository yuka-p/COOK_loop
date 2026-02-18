class ContactMailer < ApplicationMailer
  default to: "xxx@gmail.com"

  def send_mail(contact)
    @contact = contact
    mail(
      subject: "【COOK LOOP】お問い合わせが届きました",
      from: contact.email
    )
  end
end
