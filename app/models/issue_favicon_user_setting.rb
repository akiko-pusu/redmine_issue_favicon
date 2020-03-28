# frozen_string_literal: true

class IssueFaviconUserSetting < ActiveRecord::Base
  include Redmine::SafeAttributes

  belongs_to :user
  validates :user, presence: true

  safe_attributes 'favicon', 'bg_color', 'text_color', 'user_id'

  # User preference to overwride global setting and to turn on / off.
  enum favicon: { show: 'show', hide: 'hide', default: 'default' }

  def self.find_or_create_by_user_id(user_id)
    issue_favicon = IssueFaviconUserSetting.find_by(user_id: user_id)
    issue_favicon ||= IssueFaviconUserSetting.new(favicon: :default, user_id: user_id)
    issue_favicon
  end

  def self.destroy_by_user_id(user_id)
    issue_favicon = IssueFaviconUserSetting.find_by(user_id: user_id)
    issue_favicon&.destroy
  end

  def self.i18n_favicons(hash = {})
    favicons.keys.each { |key| hash[I18n.t("label_#{key}", default: key)] = key }
    hash
  end
end
