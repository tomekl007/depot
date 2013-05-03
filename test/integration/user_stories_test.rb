require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  # A user goes to the index page. They select a product, adding it to their
  # cart, and check out, filling in their details on the checkout form. When
  # they submit, an order is created containing their information, along with a
  # single line item corresponding to the product they added to their cart.

  test 'buying a product' do
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)

    #a user goes to index store page
    get "/"
    assert_response :success
    assert_template "index"

    #They select a product, adding it to their cart.
    request :post, '/line_items', :product_id => ruby_book.id
    assert_response :success

    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product

    #They then check out....
    get "/orders/new"
    assert_response :success
    assert_template 'new'
    #send post to orders controller
    post_via_redirect "/orders",
                      :order => {:name => "Dave Thomas",
                                 :address => "123 The Street",
                                 :email => "dave@example.com",
                                 :pay_type => "Check"}
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    #verify database state
    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]
    assert_equal "Dave Thomas", order.name
    assert_equal "123 The Street", order.address
    assert_equal "dave@example.com", order.email
    assert_equal "Check", order.pay_type
    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product

    #verify email
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal 'Sam Ruby <depot@example.com>', mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject


  end



  test "buying a product" do
    # existing code here...
    ship_date_expected = Time.now.to_date    ### new line
    post_via_redirect "/orders", ### existing line
                      # existing code here...
                      assert_equal "Check", order.pay_type  ### existing line
    assert_equal ship_date_expected, order.ship_date.to_date  ### new line
    # existing code here...
  end

  test "should mail the admin when error occurs" do
  get 'line_items/badRequest'
  mail = ActionMailer::Base.deliveries.last
  assert_equal ["tomekl007@gmail.com"], mail.to

  assert_equal "Depot App Error Incident", mail.subject

  end

end
