require 'orders_items_repository'
require 'orders_repository'
require 'items_repository'
require 'order'
require 'item'

RSpec.describe 'integration' do
  def reset_orders_items_table
    seed_sql = File.read('spec/seeds_orders_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end
  

  before(:each) do
    reset_orders_items_table
    
  end
  it 'returns a list of order ids and item ids' do
    repo = OrdersItemsRepository.new
    orders = repo.all
    expect(orders.length).to eq(3)
    binding.irb
    expect(orders[0][0]).to eq("1")
  end
  it 'updates the orders_items tabled whenever an order is made' do
    repo = OrdersItemsRepository.new
    orders = OrdersRepository.new
    order = Order.new
    items = ItemsRepository.new
    order.customer_name = 'Jim-Bob Jones'
    order.order_date = '26/12/2019'
    orders.create(order)
    result = repo.all
    binding.irb
    expect(result[3][0]).to eq('5')

  end
end