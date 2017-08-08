require 'redmine'
require 'issue_favicon_application_hooks'
require 'issue_favicon_my_account_hooks'
require 'issue_favicon_user_preference_patch'

Rails.configuration.to_prepare do
  # Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks
  require_dependency 'user_preference'
  unless UserPreference.included_modules.include? IssueFaviconUserPreferencePatch
    UserPreference.send(:include, IssueFaviconUserPreferencePatch)
  end
end

Redmine::Plugin.register :redmine_issue_favicon do
  name 'Redmine Issue Favicon plugin'
  author 'Akiko Takano'
  description 'Plugin to show the number of assigned issues on favicon with badge, using favico.js.'
  version '0.0.2'
  url 'https://github.com/akiko-pusu/redmine_issue_favicon'
  author_url 'http://twitter.com/akiko_pusu'
  requires_redmine version_or_higher: '3.0.0'

  settings partial: 'settings/redmine_issue_favicon',
           default: {
             'enable' => 'false'
           }
end
