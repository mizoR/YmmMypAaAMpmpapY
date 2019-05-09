class V0::My::ProductsController < V0::My::ApplicationController
  def_param_group :product do
    property :id,             Integer, 'ID'
    param    :name,           String,  'Name',                  required: true
    param    :price,          Integer, 'Price',                 required: true
    param    :stock_quantity, Integer, 'Stock quantity',        required: true
    param    :image_binary,   String,  'Image binary',          required: true, only_in: :request
    property :image_url,      String,  'Image URL'
    property :version,        Integer, 'Version'
    property :created_at,     String,  'Created date and time'
  end

  api :GET, '/my/products', '商品一覧を返す'
  header 'Authorization', 'Bearer <i>YOUR_ACCESS_TOKEN</i>', required: true
  returns array_of: :product
  error 403, 'Forbidden'
  def index
    @products = login_user.products.with_attached_image   # XXX: Use pagination

    render json: @products
  end

  api :GET, '/my/products/:id', '商品を返す'
  header 'Authorization', 'Bearer <i>YOUR_ACCESS_TOKEN</i>', required: true
  returns :product
  error 403, 'Forbidden'
  error 404, 'Not found'
  def show
    @product = login_user.products.find(params[:id])

    render json: @product
  rescue ActiveRecord::RecordNotFound
    render status: :not_found, json: Product.not_found, serializer: ErrorSerializer
  end

  api :POST, '/my/products', '商品を作成する'
  header 'Authorization', 'Bearer <i>YOUR_ACCESS_TOKEN</i>', required: true
  param_group :product
  returns code: 201 do
    param_group :product
  end
  error 403, 'Forbidden'
  error 422, 'Unprocessable entity'
  def create
    @product = login_user.products.build(product_params)

    @product.save!

    render status: :created, json: @product
  rescue ActiveRecord::RecordInvalid => e
    render status: :unprocessable_entity, json: e.record, serializer: ErrorSerializer
  end

  api :PATCH, '/my/products/:id', '商品を更新する'
  header 'Authorization', 'Bearer <i>YOUR_ACCESS_TOKEN</i>', required: true
  param_group :product
  returns :product
  error 403, 'Forbidden'
  error 404, 'Not found'
  error 422, 'Unprocessable entity'
  def update
    @product = login_user.products.find(params[:id])

    ApplicationRecord.transaction do
      @product.update!(product_params)

      @product.increment!(:version)
    end

    render status: :ok, json: @product
  rescue ActiveRecord::RecordNotFound
    render status: :not_found, json: Product.not_found, serializer: ErrorSerializer
  rescue ActiveRecord::RecordInvalid => e
    render status: :unprocessable_entity, json: e.record, serializer: ErrorSerializer
  end

  api :DELETE, '/my/products/:id', '商品を削除する'
  header 'Authorization', 'Bearer <i>YOUR_ACCESS_TOKEN</i>', required: true
  returns code: 204
  error 403, 'Forbidden'
  error 404, 'Not found'
  def destroy
    @product = login_user.products.find(params[:id])

    @product.destroy
  rescue ActiveRecord::RecordNotFound
    render status: :not_found, json: Product.not_found, serializer: ErrorSerializer
  end

  private

  def product_params
    params.permit(:name, :price, :stock_quantity, :image_binary)
  end
end
