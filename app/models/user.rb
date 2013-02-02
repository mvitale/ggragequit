require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  validates :username, :presence => true, 
                       :uniqueness => true,
                       :length => { :minimum => 5, :maximum => 20 }
  validates :email,    :presence => true, 
                       :uniqueness => true
  validates :password_hash, :presence => true
  
  has_many :posts
  has_many :replies

  attr_accessible :email, :username, :password_hash

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(name, password)
    user = find_by_username(name)

    if user and user.password == password
      user
    else
      nil
    end
  end

  def self.authenticate_session_user(name, password_hash)
    if name.nil? or password_hash.nil? then
      nil
    else
      User.authenticate(name, Password.new(password_hash))
    end
  end
end

