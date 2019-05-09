module RequestSpecAuthentication
  def login_as(user)
    token = user.tokens.issue

    headers.merge!('HTTP_AUTHORIZATION' => "Bearer #{token.access_token}")
  end
end
