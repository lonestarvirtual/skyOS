class Contact
  include ActiveModel::Model
  attr_accessor :first_name, :last_name, :email, :message

  validates :first_name, :last_name, :email, :message, presence: true
end
