class IssueFaviconApplicationHooks < Redmine::Hook::ViewListener
  include ApplicationHelper

  def view_layouts_base_html_head(_context = {})
    o = ''
    if User.current.logged?
      global_enabled = Setting.plugin_redmine_issue_favicon['enable'] == 'true'
      issue_favicon = IssueFaviconUserSetting.find_or_create_by_user_id(User.current.id)
      return if issue_favicon.hide?
      if issue_favicon.show? || global_enabled
        color_option = user_pref_colors(issue_favicon)

        my_issue_count = Issue.visible.open.where(assigned_to_id: ([User.current.id] + User.current.group_ids)).size
        o = stylesheet_link_tag('style', plugin: 'redmine_issue_favicon')
        o << javascript_include_tag('favico', plugin: 'redmine_issue_favicon')
        o << javascript_include_tag('issue_favicon', plugin: 'redmine_issue_favicon')
        o << "\n".html_safe + javascript_tag("favicon.badge('#{escape_javascript my_issue_count.to_s}');")
        o << "\n".html_safe + javascript_tag("favicon.setOpt(#{color_option});") if color_option
      end
    end
    o
  end

  def user_pref_colors(issue_favicon)
    return nil unless issue_favicon && issue_favicon.user_id.present?

    bg_color = issue_favicon.bg_color || '#008080'
    text_color = issue_favicon.text_color || '#ff0000'

    "{ bgColor: '#{bg_color}', textColor: '#{text_color}' }"
  end
end
