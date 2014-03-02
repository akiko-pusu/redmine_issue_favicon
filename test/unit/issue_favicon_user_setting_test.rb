require File.expand_path('../../test_helper', __FILE__)

class IssueFaviconUserSettingTest < ActiveSupport::TestCase
  fixtures :users, :issue_favicon_user_settings

  def setup
    @favicon = IssueFaviconUserSetting.find_by_user_id(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end

  def test_favicon_enabled
    enabled = @favicon.enabled?
    assert_equal false, enabled, @favicon.enabled?

    @user = User.find(1)
    assert_equal false, @user.pref.issue_favicon, @user.pref.issue_favicon

    @favicon.enabled = true
    @favicon.save!
    enabled = @favicon.enabled?
    assert_equal true, enabled, @favicon.enabled?
  end

  def test_favcon_create
    @favicon = IssueFaviconUserSetting.find_or_create_by_user_id(3)

    # test default value
    enabled = @favicon.enabled?
    assert_equal false, enabled, @favicon.enabled?
  end

  def test_favicon_destroy
    IssueFaviconUserSetting.destroy_by_user_id(3)
    @favicon = IssueFaviconUserSetting.where(:user_id => 3)
    assert_equal [], @favicon, @favicon
  end

  def test_user_preference
    @user = User.find(2)
    assert_equal true, @user.pref.issue_favicon, @user.pref.issue_favicon

    @user.pref.issue_favicon = false
    assert_equal false, @user.pref.issue_favicon, @user.pref.issue_favicon
  end

  def test_favicon_destroy_via_user_pref
    @user = User.find(2)
    @user.pref.destroy_issue_favicon
    @favicon = IssueFaviconUserSetting.where(:user_id => 2)
    assert_equal [], @favicon, @favicon
  end

end
