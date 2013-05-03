class PaymentType < ActiveRecord::Base
  attr_accessible :name
  def self.all_names
    all.collect { |payment_type| payment_type.name}
  end
end
