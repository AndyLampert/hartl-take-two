class User < ActiveRecord::Base
	has_many :microposts
	validates :name, presence: true, length: { minimum: 5 }
	validates :email, presence: true, length: { minimum: 5 }
end

