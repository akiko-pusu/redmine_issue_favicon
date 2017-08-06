require File.expand_path('../../test_helper', __FILE__)

class LayoutTest < Redmine::IntegrationTest
  fixtures :projects, :trackers, :issue_statuses, :issues,
           :enumerations, :users,
           :projects_trackers,
           :roles,
           :member_roles,
           :members,
           :enabled_modules,
           :workflows,
           :issue_favicon_user_settings

  def test_issue_favicon_not_visible_when_preference_off
    # module -> disabled
    log_user('admin', 'admin')

    post '/my/account', user: { mail: 'admin@example.net' }, pref: { issue_favicon: :show }
    assert_redirected_to '/my/account'
    get '/'

    assert_response :success
    assert_select 'head link:match("href", ?)', '/plugin_assets/redmine_issue_favicon/stylesheets/style.css'
    assert_select 'head script:match("src", ?)', '/plugin_assets/redmine_issue_favicon/javascripts/favico.js'

    post '/my/account', pref: { issue_favicon: :hide }

    assert_redirected_to '/my/account'
    get '/'
    assert_response :success
    assert_select 'head link:match("href", ?)', '/plugin_assets/redmine_issue_favicon/stylesheets/style.css', count: 0
    assert_select 'head script:match("src", ?)', '/plugin_assets/redmine_issue_favicon/javascripts/favico.js', count: 0
  end
end
