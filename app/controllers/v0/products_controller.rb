class V0::ProductsController < V0::ApplicationController
  def_param_group :product do
    property :id,             Integer, 'ID'
    property :name,           String,  'Name'
    property :price,          Integer, 'Price'
    property :stock_quantity, Integer, 'Stock quantity'
    property :version   ,     Integer, 'Version'
    property :created_at,     String,  'Created date and time'
  end

  api :GET, '/products', '商品一覧を返す'
  param :id_lt, Integer, 'ID to filter products.  - Less than'
  returns array_of: :product
  def index
    id_lt = Integer(params[:id_lt]) rescue Float::INFINITY

    @products = Product
      .with_attached_image
      .where(id: -Float::INFINITY..id_lt)
      .order('id DESC')
      .limit(50)

    render json: @products
  end
end
