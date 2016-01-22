class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(username: "Example User",
                     email: "user@example.com",
                     first_name: "Example",
                     last_name: "User",
                     password: "password",
                     password_confirmation: "password")
  end

  test "shoud new valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.username = " " * 6
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = " " * 6
    assert_not @user.valid?
  end

  test "first name should be present" do
    @user.first_name = " " * 6
    assert_not @user.valid?
  end

  test "last name should be present" do
    @user.last_name = " " * 6
    assert_not @user.valid?
  end

  test "username should not be to long" do
    @user.username = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be to long" do
    @user.email = "a" * 247  + "@test.com"
    assert_not @user.valid?
  end

  test "first name should not be to long" do
    @user.first_name = "a" * 51
    assert_not @user.valid?
  end

  test "last name should not be to long" do
    @user.last_name = "a" * 51
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_emails = %w[test@example.com TEST@example.com t_ji-s@uj.com
                         a+b@gmail.com d.l@test.com]
    valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid?, "#{valid_email.inspect} is a valid address"
    end
  end

  test "email validation of invalid address should reject them" do
    invalid_emails = %w[g_g.com test@bad. foo@no_here.jp li@li+li.com
                       mistake@whoops,com]
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email.inspect} should be invalid"
    end
  end

  
end
