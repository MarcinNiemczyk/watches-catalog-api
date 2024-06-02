class Api::V1::WatchesSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :image

  attribute :category do
    object.category.name
  end
end
