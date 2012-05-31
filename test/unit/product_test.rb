require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # Replace this with your real tests.

  test "product is not valid without a unique title" do
  	product = Product.new(
  			:title => products(:ruby).title,
  			:description => products(:ruby).description,
  			:image_url => products(:ruby).image_url,
  			:price => products(:ruby).price
  		)
  	assert !product.save
  	assert_equal "has already been taken", product.errors[:title].join('; ')
  end

  test "product attributes must not be empty" do
  	product = Product.new
  	assert product.invalid?
  	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:image_url].any?
  	assert product.errors[:price].any?
  end

  test "product price must be positive" do
  	product = Product.new(
  			:title => "My book title",
  			:description => "My book description",
  			:image_url => "book.jpg"
  		)
  	
  	product.price = -1
  	assert product.invalid?
  	assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')
  	
  	product.price = 0
  	assert product.invalid?
  	assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')

  	product.price = 1
  	assert product.valid?
  end

  def new_product(image_url)
  	product = Product.new(
  			:title => "My book title",
  			:description => "My book description",  			
  			:price => 1,
  			:image_url => image_url
  		)
  end

  test "image_url" do
  	ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
  	bad = %w{ fred.doc fred.gif/more fred.gif.more }

  	ok.each { |name|
  		assert new_product(name).valid?, "#{name} shouldn't be invalid"
  	}

  	bad.each { |name|
  		assert new_product(name).invalid?, "#{name} shouldn't be valid"
  	}
  end
end
