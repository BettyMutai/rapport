class User < ActiveRecord::Base
  has_secure_password
  has_many :people
  has_many :companies
end
