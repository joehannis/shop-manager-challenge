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
  
  def create_order_id(order_id)
    sql = 'INSERT INTO orders_items (order_id) VALUES ($1);'
    params = [order_id]
    result_order = DatabaseConnection.exec_params(sql, params)
  end
  
  def create_item_id(item_id)
    sql = 'INSERT INTO orders_items (item_id) VALUES ($1);'
    params = [item_id]
    result_item = DatabaseConnection.exec_params(sql, params)
  end



  private

  def sort_and_return
    @result_set.each do |record|
      binding.irb
      order_id = record['order_id']
      item_id = record['item_id']
      @orders << [order_id, item_id]
    end
  end
end