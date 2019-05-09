class V0::TokensController < V0::ApplicationController
  def_param_group :product do
    property :id,           Integer, 'ID'
    param    :email,        String,  'Email',                 required: true, only_in: :request
    param    :password,     String,  'Password',              required: true, only_in: :request
    property :access_token, String,  'Access token'
    property :created_at,   String,  'Created date and time'
  end

  api :POST, '/tokens', '認証トークンを作成する'
  param_group :product
  returns :product, code: 201
  error 401, 'Unauthorized'
  def create
    user = User.find_by(email: token_params[:email])

    if user&.authenticate(token_params[:password])
      @token = user.tokens.issue

      render status: :created, json: @token

      return
    end

    render status: :unauthorized, json: Token.unauthorized, serializer: ErrorSerializer
  end

  private

  def token_params
    params.permit(:email, :password)
  end
end
