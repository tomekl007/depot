class Order < ActiveRecord::Base
  attr_accessible :address, :name, :pay_type,:email
  PAYMENT_TYPES = ['check', 'credit card', 'purchase order']
  validates :name, :address,:pay_type ,:email, :presence => true
  validates :pay_type, :inclusion => Order::PAYMENT_TYPES
  has_many :line_items, :dependent => :destroy

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
     item.cart_id=nil #to prevent deleting when cart will be destroyed
      line_items << item  #add this item to line_item collection
      #in this order
    end

  end


end
