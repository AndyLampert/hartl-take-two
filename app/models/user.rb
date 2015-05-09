class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	# modeling the user with the following attributes
	# validate :name, :email
	validates :name, presence: true, length: { maximum: 50 }
	# validates is a method, it could also look like this:
	validates(:name, presence: true)
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
		format: { with: VALID_EMAIL_REGEX },
		uniqueness: { case_sensitive: false }

	# This creates a securely hased password_digest attribute to get saved to the db
	# creates password and password_confirmation virtual attributes
	# an authenticate method that returns true when the user's pw is correct
	has_secure_password
	validates :password, length: { minimum: 6 }
end
