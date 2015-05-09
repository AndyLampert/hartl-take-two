require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new(name: "Andy Test", email: "andy@andy.com",
			password: 'foobar', password_confirmation: 'foobar'	
		)
	end

	test "should be valid" do
		assert @user.valid?
	end

	test "name should be present" do
		# set the user name to a blank string
		@user.name = "  "
		# check that the user name is NOT valid
		# meaning that IF the test passes, that means the user's name isn't a blank string?
		assert_not @user.valid?
	end

	test "name should not be too long" do 
		@user.name = 'a' * 51
		assert_not @user.valid?
	end

	test "email should be present" do 
		# set the user's email to a blank string
		@user.email = "  "
		# IF the test passes, the name isn't blank
		assert_not @user.valid?
	end 

	test "email should not be too long" do 
		@user.email = 'a' * 244 + "@example.com"
		assert_not @user.valid?
	end

	test "email validation should accept valid addresses" do 
		valid_addresses = %w[
			user@example.com 
			USER@foo.COM 
			A_US-ER@foo.bar.org 
			first.last@foo.jp 
			alice+bob@baz.cn]
		valid_addresses.each do |valid_address|
			# set each of the address examples in the array above
			# and assert that they are valid
			@user.email = valid_address
			assert @user.valid?, "#{valid_address.inspect} should be valid"			
		end
	end

	test "email validation should reject invalid addresses" do
		invalid_addresses = %w[
			user@example,com 
			user_at_foo.org 
			user.name@example.
			foo@bar_baz.com 
			foo@bar+baz.com]
		invalid_addresses.each do |invalid_address|
			# in the loop, set user email to the current invalid address above 
			@user.email = invalid_address
			assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
		end

		test "email addresses should be unique" do
			# makes a user with the same email by using .dup
			duplicate_user = @user.dup
			# set the dup user's email to the instance user's email in caps
			duplicate_user.email = @user.email.upcase
			# user gets saved, meaning it has an addy that is already in the db
			# making the duplicate_user invalid
			@user.save
			assert_not duplicate_user.valid?
		end

		test "password should have a minimum length" do 
			# puts the value on the password and pw confirmation at the same time
			@user.password = @user.password_confirmation = 'a' * 5
			assert_not @user.valid?
		end

	end

end





