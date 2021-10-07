module OrdersHelper
  def total_order list_order_detail
    list_order_detail.reduce(0) do |total, order|
      total + order.quantily * order.price
    end
  end
end
