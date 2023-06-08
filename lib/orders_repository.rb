require 'order'
require 'orders_items_repository'

class OrdersRepository
  def initialize
    @order_id = []
  end
  
  def all
    sql = 'SELECT id, customer_name, order_date FROM orders;'
    @result_set = DatabaseConnection.exec_params(sql, [])
    @orders = []
    sort_and_return
  end

  def find_by_name_order(customer_name)
    sql = 'SELECT id, customer_name, order_date FROM orders WHERE customer_name = $1;'
    params = [customer_name]
    @result_set = DatabaseConnection.exec_params(sql, params)
    @orders = []
    sort_and_return
  end

  def find_by_id_order(id)
    sql = 'SELECT id, customer_name, order_date FROM orders WHERE id = $1;'
    params = [id]
    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]
    order = Order.new
    order.id = record['id']
    order.customer_name = record['customer_name']
    order.order_date = record['order_date']
    order
  end
  

  def create(order)
    sql = 'INSERT INTO orders (customer_name, order_date) VALUES ($1, $2) RETURNING id;'
    params = [order.customer_name, order.order_date]
    @result_set = DatabaseConnection.exec_params(sql, params)
    @orders = []
    sort_and_return
    order_id = @orders[0]
    binding.irb
    new_order_id = OrdersItemsRepository.new
    new_order_id.create_order_id(order_id)
  end

  private

  def sort_and_return
    @result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']
      @orders << [order.id, order.customer_name, order.order_date]
    end
    @orders
  end
end
