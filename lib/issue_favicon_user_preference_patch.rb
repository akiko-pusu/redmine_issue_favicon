module IssueFaviconUserPreferencePatch
  def self.included(base) # :nodoc:
    base.send(:include, UserPreferenceInstanceMethodsForIssueFavicon)

    base.class_eval do
      after_destroy :destroy_issue_favicon
      safe_attributes :issue_favicon if defined?(safe_attributes)
    end
  end
end

module UserPreferenceInstanceMethodsForIssueFavicon
  def issue_favicon
    issue_favicon = IssueFaviconUserSetting.find_by_user_id(user.id)
    return nil unless issue_favicon
    issue_favicon
  end

  def issue_favicon=(favicon)
    issue_favicon = IssueFaviconUserSetting.find_or_create_by_user_id(user.id)
    issue_favicon.favicon = favicon
    issue_favicon.save!
  end

  def destroy_issue_favicon
    IssueFaviconUserSetting.destroy_by_user_id(user.id)
  end
end
