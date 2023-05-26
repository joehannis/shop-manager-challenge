require 'order'
require 'orders_repository'
require 'item'
require 'items_repository'

class OrdersItemsRepository
  def all
    sql = 'SELECT order_id, item_id FROM orders_items;'
    @result_set = DatabaseConnection.exec_params(sql, [])
    @orders = []
    sort_and_return
    @orders.each do |array|
      array
    end
  end

  private

  def sort_and_return
    @result_set.each do |record|
      order = Order.new
      item = Item.new
      order.id = record['order_id']
      item.id = record['item_id']
      @orders << [order, item]
    end
  end
end