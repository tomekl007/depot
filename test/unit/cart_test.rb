require 'test_helper'

class CartTest < ActiveSupport::TestCase
  def new_cart_with_one_product(product_name)
    cart = Cart.create
    cart.add_product(products(product_name).id)
    cart
  end

  #test 'cart should create a new line item when adding a new product' do
  #  cart = new_cart_with_one_product(:one)
  #  assert_equal 1, cart.line_items.count
  #  # Add a new product
  #  cart.add_product(products(:ruby).id)
  #  assert_equal 2, cart.line_items.count
  #end
  #
  #test 'cart should update an existing line item when adding an existing product' do
  #  cart = new_cart_with_one_product(:one)
  #  # Re-add the same product
  #  cart.add_product(products(:one).id)
  #  assert_equal 1, cart.line_items.count
  #end
  #
  test 'unique_product_should_be_saved' do
    product = Product.new(:title => "unique-title",
                          :description => "a unique product",
                          :image_url => "unique.png",
                          :price => 22)
    assert product.save
  end

  test 'non_unique_product_should_error_out' do
    product = Product.new(:title => "unique-title",
                          :description => "a unique product",
                          :image_url => "unique.png",
                          :price => 22)
    assert product.save

  product = Product.new(:title => "unique-title",
                        :description => "a unique product",
                        :image_url => "unique.png",
                        :price => 22)
  assert !product.save
  assert_equal "has already been taken", product.errors[:title].join('; ')
  end

end
