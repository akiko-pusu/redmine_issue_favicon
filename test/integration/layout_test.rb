require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class LayoutTest < ActionController::IntegrationTest
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

    post '/my/account',
         :pref => { :issue_favicon => 1 }
    assert_redirected_to '/my/account'
    get '/'
    #puts @response.body
    assert_response :success
    assert_tag :link,
               :attributes => { :href => /plugin_assets\/redmine_issue_favicon\/stylesheets\/style.css/ }
    assert_tag :script,
               :attributes => { :src => /plugin_assets\/redmine_issue_favicon\/javascripts\/favico.js/ }

    post '/my/account',
         :pref => { :issue_favicon => 0 }

    assert_redirected_to '/my/account'
    get '/'
    assert_response :success
    assert_no_tag :link,
               :attributes => { :href => /plugin_assets\/redmine_issue_favicon\/stylesheets\/style.css/ }
    assert_no_tag :script,
               :attributes => { :src => /plugin_assets\/redmine_issue_favicon\/javascripts\/favico.js/ }

  end

end