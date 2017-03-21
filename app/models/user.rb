class User < ApplicationRecord
  EMAIL_REGEXP = /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i

  before_save :normalize_email

  validates :email, presence: true, format: EMAIL_REGEXP, uniqueness: { case_sensitive: false }
  has_secure_password

  has_many :bookmarks

  private

  def normalize_email
    self.email = email.delete(" ").downcase
  end
end
