require 'bundler/setup'
Bundler.require :default
require 'pry'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  erb :index
end

get '/brands' do
  @brands = Brand.all
  erb :brands
end

get '/stores' do
  @stores = Store.all
  erb :stores
end

get '/add_brand' do
  erb :add_brand
end

post '/add_brand' do
  name = params.fetch 'name'
  price = params.fetch 'price'


  brand = Brand.find_or_initialize_by name: name
  brand.save
  brand.update({:price => price})

  stores = params.fetch('stores').split(', ')
  stores.each do |store|
    stor = Store.find_or_initialize_by name: store
    stor.save
    brand.stores.push(stor)
  end

  redirect '/brands'
end

get '/brands/:id' do
  @brand = Brand.find(params.fetch('id').to_i)
  @stores = @brand.stores
  erb :brand
end

get '/stores/:id' do
  @store = Store.find(params.fetch('id').to_i)
  @brands = @store.brands
  erb :store
end

post '/stores/:id' do
  @store = Store.find(params.fetch('id').to_i)

  name = params.fetch 'name'
  brands = params.fetch('brands').split(', ')

  @store.update({:name => name})
  brands.each do |brand|
    brand = Brand.find_or_initialize_by name: brand
    brand.save
    @store.brands.push(brand)
  end
  @brands = @store.brands
  erb :store
end

post '/brands/:id' do
  @brand = Brand.find(params.fetch('id').to_i)

  stores = params.fetch('stores').split(', ')

  stores.each do |store|
    store = Store.find_or_initialize_by name: store
    store.save
    @brand.stores.push(store)
  end
  @stores = @brand.stores
  erb :brand
end

delete '/stores/:id' do
  store = Store.find(params.fetch('id').to_i)
  store.destroy
  redirect '/stores'
end

delete '/brands/:id' do
  brand = Brand.find(params.fetch('id').to_i)
  brand.destroy
  redirect '/brands'
end

get '/add_store' do
  erb :add_store
end

post '/add_store' do
  name = params.fetch 'name'

  store = Store.find_or_initialize_by name: name
  store.save

  brands = params.fetch('brands').split(', ')
  brands.each do |brand|
    brand = Brand.find_or_initialize_by name: brand
    brand.save
    store.brands.push(bran)
  end

  redirect '/stores'
end
