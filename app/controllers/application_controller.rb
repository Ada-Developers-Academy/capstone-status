class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Require authentication in production
  before_action :require_authentication, if: -> { Rails.env.production? }

  private

  def require_authentication
    realm = 'Ada Capstone Status App'
    authenticate_or_request_with_http_basic(realm) do |_, password|
      ENV['SITE_PASSWORD'].present? && password == ENV['SITE_PASSWORD']
    end
  end
end
