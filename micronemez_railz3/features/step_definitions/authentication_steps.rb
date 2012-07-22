Given /^I am a registered user$/ do
  @registered_user = Factory(:user, :email => "test@example.org", :username => "user", :created_at => 2.days.ago, :last_sign_in_at => 1.day.ago, :updated_at => 5.hours.ago, :agree => true)

end

#Given /^I am a registered admin$/ do
#  @registered_admin = Factory(:user, :email => "admin@example.org", :username => "admin", :created_at => 6.days.ago, :last_sign_in_at => 1.day.ago, :updated_at => 6.hours.ago, :agree => true)
#  @registered_admin.make_admin
#end

Given /^I am admin$/ do
  @registered_user.make_admin
end

Given /^I am logged in as admin$/ do
  steps %Q{
    Given I am a registered user
    And I am admin
    And I am on the homepage
    When I follow "Sign in"
    And I fill in "Email" with "admin@example.org"
    And I fill in "Password" with "adminpassword"
    And I press "Sign in"
  }
end
