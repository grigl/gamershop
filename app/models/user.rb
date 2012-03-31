class User < ActiveRecord::Base
  has_secure_password

  has_many :orders

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

  def admin?
    self.admin
  end

  def activate
    self.active = true
    self.activation_token = nil
    self.save!
  end

  def generate_new_password
    new_password = SecureRandom.base64(6)
    self.password = new_password
    self.password_confirmation = new_password
    save!
  end
end
