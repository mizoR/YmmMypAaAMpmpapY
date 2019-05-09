class V0::UsersController < V0::ApplicationController

  api :POST, '/users', 'ユーザを作成する'
  param :email,                 String, 'Email',                 required: true
  param :password,              String, 'Password',              required: true
  param :password_confirmation, String, 'Password confirmation', required: true
  returns code: 201 do
    property :id,         Integer, 'ID'
    property :created_at, String,  'Created date and time'
  end
  error 422, 'Unprocessable entity'
  def create
    @user = User.new(user_params)

    if @user.save
      render status: :created, json: @user
    else
      render status: :unprocessable_entity, json: @user, serializer: ErrorSerializer
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

end
