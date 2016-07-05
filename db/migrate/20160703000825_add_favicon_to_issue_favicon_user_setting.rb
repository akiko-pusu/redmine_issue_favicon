class AddFaviconToIssueFaviconUserSetting < ActiveRecord::Migration
  def change
    add_column :issue_favicon_user_settings, :favicon, :text, default: "default"

    IssueFaviconUserSetting.reset_column_information
    issue_favicon_user_settings = IssueFaviconUserSetting.all
    issue_favicon_user_settings.each do |i|
      i.favicon = i.enabled ? 'show' : 'default'
      i.save
    end
  end

  def self.down
    remove_column :issue_favicon_user_settings, :favicon
  end
end
