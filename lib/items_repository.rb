require 'item'

class ItemsRepository
  def all
    sql = 'SELECT id, item_name, price, quantity FROM items;'
    @result_set = DatabaseConnection.exec_params(sql, [])
    @items = []
    sort_and_return
  end

  def find(item_name)
    sql = 'SELECT id, item_name, price, quantity FROM items WHERE item_name = $1;'
    params = [item_name]
    @result_set = DatabaseConnection.exec_params(sql, params)
    @items = []
    sort_and_return
  end

  def create(item)
    sql = 'INSERT INTO items (item_name, price, quantity) VALUES($1, $2, $3);'
    params = [item.item_name, item.price, item.quantity]
    result = DatabaseConnection.exec_params(sql, params)
    return nil
  end

  
  private

  def sort_and_return
    @result_set.each do |record|
      item = Item.new
      item.id = record['id']
      item.item_name = record['item_name']
      item.price = record['price']
      item.quantity = record['quantity']
      @items << item
    end
    @items
  end
  
end
