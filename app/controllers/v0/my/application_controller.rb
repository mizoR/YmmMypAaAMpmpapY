class V0::My::ApplicationController < V0::ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  attr_reader :login_user

  before_action :require_login

  private

  def require_login
    authenticate_or_request_with_http_token do |access_token, _|
      @login_user = User
        .joins(:tokens)
        .order('tokens.id DESC')
        .find_by({ tokens: { access_token: access_token } })
    end

    unless @login_user
      render status: :forbidden, json: Token.forbidden, serializer: ErrorSerializer
    end
  end
end
