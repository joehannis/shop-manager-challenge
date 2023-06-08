require 'items_repository'

RSpec.describe ItemsRepository do
  def reset_items_table
    seed_sql = File.read('spec/seeds_items.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_items_table
  end
  it 'Returns a list of items' do
    repo = ItemsRepository.new
    items = repo.all
    expect(items.length).to eq(3)
    expect(items.first.id).to eq('1')
    expect(items.first.item_name).to eq "bread"
  end
  it 'Returns single item based on item_name' do
    items = ItemsRepository.new
    result = items.find_by_name_item('bread')
    expect(result.first.price).to eq '2.5'
    expect(result.first.id).to eq '1'
    expect(result.first.quantity).to eq '100'
  end
  it 'create a new item in the table' do
    repo = ItemsRepository.new
    item = Item.new
    item.item_name = 'rice'
    item.price = 0.5
    item.quantity = 400
    repo.create(item)
    all_items = repo.all
    expect(all_items).to include(have_attributes(item_name: item.item_name, price: "0.5", quantity: "400"))
  end
end
