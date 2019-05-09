class V0::My::ReceivedOrdersController < V0::My::ApplicationController
  def_param_group :received_order do
    property :id,              Integer, 'ID'
    property :product_name,    String,  'Product name'
    property :product_price,   Integer, 'Product price'
    property :order_quantity,  Integer, 'Order quantity',        required: true
    property :orderer_name,    String,  'Orderer name',          required: true
    property :orderer_address, String,  'Orderer address',       required: true
    property :created_at,      String,  'Created date and time'
  end

  api :GET, '/my/received_orders', '受注一覧を返す'
  header 'Authorization', 'Bearer <i>YOUR_ACCESS_TOKEN</i>', required: true
  returns array_of: :received_order
  error 403, 'Forbidden'
  def index
    @received_orders = login_user.received_orders

    render json: @received_orders
  end

  api :GET, '/my/received_orders/:id', '受注を返す'
  header 'Authorization', 'Bearer <i>YOUR_ACCESS_TOKEN</i>', required: true
  returns :received_order
  error 403, 'Forbidden'
  error 404, 'Not found'
  def show
    @received_order = login_user.received_orders.find(params[:id])

    render json: @received_order
  rescue ActiveRecord::RecordNotFound
    render status: :not_found, json: ReceivedOrder.not_found, serializer: ErrorSerializer
  end
end
