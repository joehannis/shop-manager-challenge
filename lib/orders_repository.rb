require 'order'

class OrdersRepository
  def all
    sql = 'SELECT id, customer_name, order_date FROM orders;'
    @result_set = DatabaseConnection.exec_params(sql, [])
    @orders = []
    sort_and_return
  end

  def find(customer_name)
    sql = 'SELECT id, customer_name, order_date FROM orders WHERE customer_name = $1;'
    params = [customer_name]
    @result_set = DatabaseConnection.exec_params(sql, params)
    @orders = []
    sort_and_return
  end

  def create(order)
    sql = 'INSERT INTO orders (customer_name, order_date) VALUES ($1, $2) RETURNING id;'
    params = [order.customer_name, order.order_date]
    result = DatabaseConnection.exec_params(sql, params)
    order_id = result[0]['id']
    insert_into_orders_items_table(order_id)
  end


  
  private

  def sort_and_return
    @result_set.each do |record|
      order = Order.new
      order.id = record['id']
      order.customer_name = record['customer_name']
      order.order_date = record['order_date']
      @orders << order
    end
    @orders
  end

  def insert_into_orders_items_table(order_id)
    sql = 'INSERT INTO orders_items (order_id) VALUES ($1);'
    params = [order_id]
    DatabaseConnection.exec_params(sql, params)
  end
  
end
