class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :username, :password, :password_confirmation
  attr_accessible :all, as: :admin

  email_regex = /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: email_regex }
  validates :username, uniqueness: true,
                       format: { with: /^[-\w\._]+$/i, 
                                 message: "should only contain letters, numbers, or .-_" }
  validates :password, length: { minimum: 6 },
                       presence: true, on: :create,
                       allow_blank: true

  before_create :generate_auth_token

  def generate_auth_token
    generate_token(:auth_token)
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column]) 
  end
end
