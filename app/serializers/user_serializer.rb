class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :password_digest, :api_key
end
