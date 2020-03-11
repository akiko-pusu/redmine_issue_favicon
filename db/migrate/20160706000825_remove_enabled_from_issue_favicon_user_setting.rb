if ActiveRecord.gem_version >= Gem::Version.new('5.0')
  class RemoveEnabledFromIssueFaviconUserSetting < ActiveRecord::Migration[4.2]; end
else
  class RemoveEnabledFromIssueFaviconUserSetting < ActiveRecord::Migration; end
end
RemoveEnabledFromIssueFaviconUserSetting.class_eval do
  def self.up
    remove_column :issue_favicon_user_settings, :enabled
  end

  def self.down
    add_column :issue_favicon_user_settings, :enabled, :boolean
  end
end
