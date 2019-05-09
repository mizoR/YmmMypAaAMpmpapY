class TokenSerializer < ActiveModel::Serializer
  attributes :id, :access_token, :created_at
end
