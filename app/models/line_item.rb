class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :product
  belongs_to :product
  belongs_to :cart
  #if a table has foreign keys, the corresponding model
  #should have a belongs_to for each.
end
