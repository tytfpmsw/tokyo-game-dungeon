class ApplicationController < ActionController::Base

  before_action :basic_auth

  private

  def basic_auth
    if Rails.env.staging?
      authenticate_or_request_with_http_basic do |username, password|
        username == Rails.application.credentials.basic_auth[:name] && password == Rails.application.credentials.basic_auth[:password]
      end
    end
  end
end
