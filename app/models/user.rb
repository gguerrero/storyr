require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation

  name_regexp     = /\A[a-z\d\_\-\.]+\z/i
  email_regexp    = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  password_regexp = /(?=.*[A-Z])(?=.*[a-z])(?=.*\d)/
  
  validates_presence_of   :name, :email,
                          :password, :password_confirmation
  validates_uniqueness_of :name, :email, case_sensitive: false

  validates :name,     length:   { within: 4..20 },
                       format:   { with: name_regexp }
  validates :email,    format:   { with: email_regexp }
  validates :fullname, length:   { maximum: 40 }
  validates :password, confirmation: true,
                       length: { within: 6..40 },
                       format: { with: password_regexp }

  before_save :encrypt_password

  def has_password?(submitted_password)
    self.encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(username, password)
    user = find_by(name: username) || find_by(email: username)
    (user and user.has_password? password) ? user : nil
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by(id: id)
    (user and user.salt == cookie_salt) ? user : nil
  end

  private
  def encrypt_password
    self.salt = make_salt
    self.encrypted_password = encrypt(self.password)
  end
  
  def make_salt
    secure_hash("#{Time.now.utc} <-> #{password} <-> #{rand(Time.now.to_i)}")
  end

  def encrypt(string)
    secure_hash("#{string} with [#{salt}]")
  end
  
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end