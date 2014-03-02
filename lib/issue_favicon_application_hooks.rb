class IssueFaviconApplicationHooks < Redmine::Hook::ViewListener
  include ApplicationHelper

  def view_layouts_base_html_head(context = {})
    o = ''
    if User.current.logged?
      e = User.current.pref.issue_favicon
      if e == true
        my_issue_count = Issue.visible.open.where(:assigned_to_id => ([User.current.id] + User.current.group_ids)).size
        o = stylesheet_link_tag('style', :plugin => 'redmine_issue_favicon')
        o << javascript_include_tag('favico', :plugin => 'redmine_issue_favicon')
        o << javascript_include_tag('issue_favicon', :plugin => 'redmine_issue_favicon')
        o << "\n".html_safe + javascript_tag("favicon.badge('#{escape_javascript my_issue_count.to_s}');")
      end
    end
    return o
  end
end