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
    expect(orders[0][1].id).to eq('1')
  end
  xit 'creates an order using order and item ids' do
    repo = OrdersRepository.new
    order = Order.new
    order.customer_name = 'Jim-Bob Jones'
    order.order_date = '26/12/2019'
    repo.create(order)
    all_orders = repo.all
    expect(all_orders).to include(have_attributes(customer_name: order.customer_name, order_date: order.order_date))
    expect(order_items.id).to eq
  end
end