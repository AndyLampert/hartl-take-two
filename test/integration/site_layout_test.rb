require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

	def setup
		@base_title = "Rails tut"
	end
	test "layout links" do
		get root_path
		assert_template 'static_pages/home'
		# Rails will put the path into the ?
		assert_select 'a[href=?]', root_path, count: 2
		assert_select 'a[href=?]', help_path
		assert_select 'a[href=?]', about_path
		assert_select 'a[href=?]', contact_path
		get signup_path
		assert_select "title", "Sign Up | #{@base_title}"
	end
end
