class ProductSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :price, :image_url, :stock_quantity, :version, :created_at

  def image_url
    rails_blob_url(object.image)
  end
end
