require 'digest/sha1'

class User
  include Cequel::Record
  
  before_save { self.email = email.downcase }

  before_save :hash_password
  after_save :clear_password
  
  validate :password_same
  
  attr_accessor :password
  attr_accessor :password_confirmation
  
  key :username, :text, :index => true
  column :email, :text
  column :password_digest, :text
  column :first_name, :text
  column :last_name, :text
  column :salt, :text
  
  EMAIL_VALIDATE_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  validates :username, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: EMAIL_VALIDATE_REGEX }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :password_confirmation, presence: true, length: { minimum: 6 },
            allow_nil: true
  
  
  def authenticate(string='')
    string = BCrypt::Engine.hash_secret(string, self.salt)
    if string == self.password_digest
      return true
    else
      return false
    end
  end
  
  def User.find_by(value)
    begin
      self.find_by_username(value)
    rescue
      return nil
    end
  end
  
  private
  def password_same
    if password != password_confirmation
      errors.add(:password_confirmation, "Password do not match")
    end
  end
  
  private
  def hash_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password_digest = BCrypt::Engine.hash_secret(password, salt)
    end
  end
  
  def clear_password
    self.password = nil
  end
end
