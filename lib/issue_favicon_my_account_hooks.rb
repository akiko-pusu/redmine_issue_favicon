class IssueFaviconMyAccountHooks < Redmine::Hook::ViewListener
  render_on :view_my_account_preferences, :partial => 'my/issue_favicon_form', :multipart => true
end