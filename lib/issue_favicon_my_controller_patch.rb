# frozen_string_literal: true

module IssueFaviconMyControllerPatch
  extend ActiveSupport::Concern

  def account
    user = User.current

    @issue_favicon = IssueFaviconUserSetting.find_or_create_by_user_id(user.id)

    if put_request? || request.post?
      begin
        logger.info(favicon_params)
        # binding.pry
        logger.warn "Can't save IssueFavicon. #{@issue_favicon.errors.messages}" unless @issue_favicon.update(favicon_params)
      rescue StandardError => e
        logger.warn "Can't save IssueFavicon. #{e.message}"
      end
    end
    super
  end

  private

  def favicon_params
    params.require(:issue_favicon).permit(:favicon, :bg_color, :text_color)
  end

  def put_request?
    return true if request.put?
    return false if request.method == 'POST'

    params[:_method].present? && params[:_method] == 'put'
  end
end
