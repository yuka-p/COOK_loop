class ContactForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :email, :string
  attribute :message, :string

  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "は正しいメール形式ではありません" }
  validates :message, presence: true, length: { minimum: 10, maximum: 5000 }
end
