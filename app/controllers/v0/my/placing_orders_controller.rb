class V0::My::PlacingOrdersController < V0::My::ApplicationController
  before_action :set_product, only: [:create]

  def_param_group :placing_order do
    property :id,                    Integer, 'ID'
    param    :product_id,            Integer, 'Product ID',            required: true, only_in: :request
    property :product_name,          String,  'Product name'
    property :product_price,         Integer, 'Product price'
    param    :order_product_version, Integer, 'Order product version', required: true, only_in: :request
    param    :order_quantity,        Integer, 'Order quantity',        required: true
    param    :orderer_name,          String,  'Orderer name',          required: true
    param    :orderer_address,       String,  'Orderer address',       required: true
    property :created_at,            String,  'Created date and time'
  end

  api :GET, '/my/placing_orders', '発注一覧を返す'
  header 'Authorization', 'Bearer <i>YOUR_ACCESS_TOKEN</i>', required: true
  returns array_of: :placing_order
  error 403, 'Forbidden'
  def index
    @placing_orders = login_user.placing_orders

    render json: @placing_orders
  end

  api :GET, '/my/placing_orders/:id', '発注を返す'
  header 'Authorization', 'Bearer <i>YOUR_ACCESS_TOKEN</i>', required: true
  returns :placing_order
  error 403, 'Forbidden'
  error 404, 'Not found'
  def show
    @placing_order = login_user.placing_orders.find(params[:id])

    render json: @placing_order
  rescue ActiveRecord::RecordNotFound
    render status: :not_found, json: PlacingOrder.not_found, serializer: ErrorSerializer
  end

  api :POST, '/my/placing_orders', '発注を作成する'
  header 'Authorization', 'Bearer <i>YOUR_ACCESS_TOKEN</i>', required: true
  param_group :placing_order
  returns :placing_order
  error 403, 'Forbidden'
  error 422, 'Unprocessable entity'
  def create
    @placing_order = login_user.placing_orders.build(order_params)

    login_user.place_order!(@placing_order, @product)

    render status: :created, json: @placing_order
  rescue ActiveRecord::RecordInvalid => e
    render status: :unprocessable_entity, json: e.record, serializer: ErrorSerializer
  end

  private

  def set_product
    product_id = params.require(:product_id)

    @product = Product.find(product_id)
  rescue ActiveRecord::RecordNotFound
    render status: :not_found, json: Product.not_found, serializer: ErrorSerializer
  end

  def order_params
    params.permit(:orderer_name, :orderer_address, :order_quantity, :order_product_version)
  end
end
