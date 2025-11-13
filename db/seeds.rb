u = User.find_or_create_by!(email: "demo@example.com") do |x|
  x.name = "Demo"
  x.password = "password"
end

p1 = Product.find_or_create_by!(sku: "A-100") { |p| p.name = "Widget A"; p.price_cents = 1999; p.status = :active }
p2 = Product.find_or_create_by!(sku: "B-200") { |p| p.name = "Widget B"; p.price_cents = 2999; p.status = :active }

o  = Orders::Create.call(user: u, items: [{ product_id: p1.id, quantity: 2 }, { product_id: p2.id, quantity: 1 }])
