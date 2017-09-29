require("bundler/setup")
require('pry')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/')do
  erb(:index)
end

get('/stores') do
  @stores = Store.all()
  erb(:stores)
end

get('/brands')do
  @brands = Brand.all()
  erb(:brands)
end

get('/store_form')do
  erb(:store_form)
end

get('/brand_form')do
  erb(:brand_form)
end

post('/')do
  name = params.fetch('name')
  store = Store.new({:name => name})
  store.save()
  @stores = Store.all()
  erb(:stores)
end

get('/store/:id') do
  id = params[:id].to_i
  @store = Store.find(id)
  erb(:store_detail)
end

post('/')do
  name = params.fetch('name')
  params.fetch('price')
  brand = Brand.new({:name => name, :price => price})
  brand.save()
  @brands = Brand.all()
  erb(:brands)
end
