class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :api_key
end
