class PlaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :city, :state, :created_at, :updated_at
end
