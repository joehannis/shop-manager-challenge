require 'orders_repository'

RSpec.describe OrdersRepository do
  def reset_orders_table
    seed_sql = File.read('spec/seeds_orders.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_orders_table
  end
  it 'Returns a list of orders' do
    repo = OrdersRepository.new
    orders = repo.all
    expect(orders.length).to eq(3)
    expect(orders.first.customer_name).to eq('John Doe')
    expect(orders.first.order_date).to eq ('26/05/2023')
  end
  it 'Returns single order based on customer_name' do
    orders = OrdersRepository.new
    result = orders.find_by_name_order('John Doe')
    expect(result.first.customer_name).to eq 'John Doe'
    expect(result.first.order_date).to eq '26/05/2023'
  end
  it 'create a new order in the table' do
    repo = OrdersRepository.new
    order = Order.new
    order.customer_name = 'Jim-Bob Jones'
    order.order_date = '26/12/2019'
    repo.create(order)
    all_orders = repo.all
    expect(all_orders).to include(have_attributes(customer_name: order.customer_name, order_date: order.order_date))
  end
end
