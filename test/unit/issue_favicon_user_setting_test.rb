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

  def test_favicon_show?
    enabled = @favicon.show?
    assert_equal false, enabled, @favicon.show?

    @user = User.find(1)
    assert_equal false, @user.pref.issue_favicon.show?

    @favicon.favicon = IssueFaviconUserSetting.favicons[:show]
    @favicon.save!
    @user.reload
    assert_equal true, @user.pref.issue_favicon.show?
  end

  def test_favcon_create
    @favicon = IssueFaviconUserSetting.find_or_create_by_user_id(3)

    # test default value
    assert_equal false, @favicon.show?
  end

  def test_favicon_destroy
    IssueFaviconUserSetting.destroy_by_user_id(3)
    @favicon = IssueFaviconUserSetting.where(user_id: 3)
    assert_equal [], @favicon, @favicon
  end

  def test_user_preference
    @user = User.find(2)
    assert_equal true, @user.pref.issue_favicon.show?, @user.pref.issue_favicon.favicon

    @user.pref.issue_favicon = 'hide'
    assert_equal false, @user.pref.issue_favicon.show?, @user.pref.issue_favicon.favicon
  end

  def test_favicon_destroy_via_user_pref
    @user = User.find(2)
    @user.pref.destroy_issue_favicon
    @favicon = IssueFaviconUserSetting.where(user_id: 2)
    assert_equal [], @favicon, @favicon
  end
end
