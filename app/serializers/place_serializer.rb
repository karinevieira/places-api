class PlaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :city, :state, :created_at, :updated_at
end
