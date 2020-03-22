if ActiveRecord.gem_version >= Gem::Version.new('5.0')
  class CreateIssueFaviconUserSettings < ActiveRecord::Migration[4.2]; end
else
  class CreateIssueFaviconUserSettings < ActiveRecord::Migration; end
end
CreateIssueFaviconUserSettings.class_eval do
  def change
    create_table :issue_favicon_user_settings do |t|
      t.integer :user_id
      t.boolean :enabled
      t.column :created_on, :timestamp
      t.column :updated_on, :timestamp
    end
    add_index :issue_favicon_user_settings, :user_id
  end

  def self.down
    remove_index :issue_favicon_user_settings, :user_id
    drop_table :issue_favicon_user_settings
  end
end
