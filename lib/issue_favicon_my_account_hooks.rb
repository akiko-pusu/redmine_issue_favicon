class IssueFaviconMyAccountHooks < Redmine::Hook::ViewListener
  render_on :view_my_account, partial: 'my/issue_favicon_form', multipart: true
end
