require("bundler/setup")
require('pry')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/')do
  erb(:index)
end

get('/stores')do
  @stores = Store.all()
  erb(:stores)
end

get('/brands')do
  @brands = Brand.all()
  erb(:brands)
end

get('/store/:id') do
  @store = Store.find(params[:id])
  erb(:store_detail)
end

get('/brand/:id') do
  @brand = Brand.find(params[:id])
  erb(:brand_detail)
end

get('/store_form')do
  erb(:store_form)
end

post('/store_form')do
  name = params.fetch('name')
  @store = Store.create({:name => name})
  store.save()
  redirect ('/stores')
end


get('/stores/:id/edit') do
  @store = Store.find(params[:id].to_i)
  erb(:store_edit)
end

patch('/stores/:id') do
  @section = 'stores'
  @store = Store.find(params[:id].to_i)
  if @store.update({name: params['name']})
    redirect '/stores/' + @store.id.to_s
  else
    erb(:store_edit)
  end
end

delete('/delete/:id') do
  store_id = params[:id].to_i
  Store.where(id: store_id).destroy_all
  redirect to("/")
end

get('/brand_form')do
  erb(:brand_form)
end

post('/brand_form')do
  name = params.fetch('name')
  price = params.fetch('price')
  brand = Brand.new({:name => name, :price => price})
  brand.save()
  erb(:brands)
end
