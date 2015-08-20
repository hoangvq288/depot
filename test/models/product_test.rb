require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  fixtures :products
  
  test "product attr must not be empty" do
  	product = Product.new
  	assert product.invalid?
  	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:price].any?
  	assert product.errors[:image_url].any?
	end

	test "product price must be positive" do
		product = Product.new(title: products(:one).title,
					description: "This is new product 1",
					image_url: 'abc.jpg')
		product.price = -1
		assert product.invalid?
		assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

		product.price = 0
		assert product.invalid?
		assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

		product.price = 1
		assert product.valid?
	end

	def new_product(image_url)
		Product.new(title: "Product 1",
								description: "Test cho vi",
								price: 1,
								image_url: image_url)
	end

	test "image url" do
		ok = %w{abc.gif abc.jpg abc.png ABC.JPG FRED.Jpg http://a.b.c/x/y/z/abc.gif}
		bad = %w{ abc.doc abc.gif/more abc.gif.more}
		ok.each do |name|
			assert new_product(name).valid?, "#{name} should be valid"
		end

		bad.each do |name|
			assert new_product(name).invalid?, "#{name} should not be valid"
		end
	end

end