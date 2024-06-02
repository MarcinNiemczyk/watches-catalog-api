class Api::V1::WatchesSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :image
end
