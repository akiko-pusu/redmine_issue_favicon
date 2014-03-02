module IssueFaviconUserPreferencePatch
  def self.included(base) # :nodoc:
    base.send(:include, UserPreferenceInstanceMethodsForIssueFavicon)

    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      after_destroy :destroy_issue_favicon

    end

  end
end

module UserPreferenceInstanceMethodsForIssueFavicon
  def issue_favicon
    issue_favicon = IssueFaviconUserSetting.find_by_user_id(user.id)
    return nil unless issue_favicon
    issue_favicon.enabled
  end

  def issue_favicon=(enabled)
    issue_favicon = IssueFaviconUserSetting.find_or_create_by_user_id(user.id)
    issue_favicon.enabled = enabled
    issue_favicon.save!
  end

  def destroy_issue_favicon
    IssueFaviconUserSetting.destroy_by_user_id(user.id)
  end
end