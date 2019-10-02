require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative("./models/pizza_order")
also_reload("./models/*")

# INDEX route
get "/pizza-orders" do
  @orders = PizzaOrder.all()
  erb(:index)
end

# NEW route
get "/pizza-orders/new" do
  erb(:new)
end

#POST route
post "/pizza-orders" do
  @order = PizzaOrder.new(params)
  @order.save()
  erb(:create)
end

# SHOW route
get "/pizza-orders/:id" do
  @order = PizzaOrder.find(params["id"])
  erb(:show)
end

get "/pizza-orders/:id/edit" do
  @order = PizzaOrder.find(params["id"])
  erb(:edit)
end

post "/pizza-orders/:id" do
  @order = PizzaOrder.find(params[:id])
  @order.first_name = params["first_name"]
  @order.last_name = params["last_name"]
  @order.topping = params["topping"]
  @order.quantity = params["quantity"]
  @order.update()
  erb(:show)
end

post "/pizza-orders/:id/delete" do
  @order = PizzaOrder.find(params[:id])
  @order.delete()
  redirect "/pizza-orders"
end
