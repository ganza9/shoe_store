require("bundler/setup")
require('pry')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @stores = Store.all()
  erb(:index)
end

get('/form')do
  erb(:form)
end

post('/')do
  name = params.fetch('name')
  store = Store.new({:name => name})
  store.save()
  erb(:index)
end

get('/store/:id') do
  id = params[:id].to_i
  @store = Store.find(id)
  @brand = Brand.find(id)
  erb(:store_detail)
end
