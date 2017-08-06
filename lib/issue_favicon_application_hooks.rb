class IssueFaviconApplicationHooks < Redmine::Hook::ViewListener
  include ApplicationHelper

  def view_layouts_base_html_head(_context = {})
    o = ''
    if User.current.logged?
      global_enabled = Setting.plugin_redmine_issue_favicon['enable'] == 'true'
      issue_favicon = IssueFaviconUserSetting.find_or_create_by_user_id(User.current.id)
      return if issue_favicon.hide?
      if issue_favicon.show? || global_enabled
        my_issue_count = Issue.visible.open.where(assigned_to_id: ([User.current.id] + User.current.group_ids)).size
        o = stylesheet_link_tag('style', plugin: 'redmine_issue_favicon')
        o << javascript_include_tag('favico', plugin: 'redmine_issue_favicon')
        o << javascript_include_tag('issue_favicon', plugin: 'redmine_issue_favicon')
        o << "\n".html_safe + javascript_tag("favicon.badge('#{escape_javascript my_issue_count.to_s}');")
      end
    end
    o
  end
end
