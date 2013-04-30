class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  #if we delete cart, then all line_items should be deleted too
   attr_accessible :line_items
end
