Product.transaction do
	(1..100).each do |i|
		Product.create(title: "Product #{i}", description: "Description product #{i}",
					 image_url: "img#{i}.jpg", price: 10.00*i)
	end
end