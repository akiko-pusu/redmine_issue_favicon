if ActiveRecord.gem_version >= Gem::Version.new('5.0')
  class AddColorsToIssueFaviconUserSetting < ActiveRecord::Migration[4.2]; end
else
  class AddColorsToIssueFaviconUserSetting < ActiveRecord::Migration; end
end

AddColorsToIssueFaviconUserSetting.class_eval do
  def self.up
    add_column :issue_favicon_user_settings, :bg_color, :string
    add_column :issue_favicon_user_settings, :text_color, :string
  end

  def self.down
    remove_column :issue_favicon_user_settings, :bg_color
    remove_column :issue_favicon_user_settings, :text_color
  end
end