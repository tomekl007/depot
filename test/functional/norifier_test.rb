require 'test_helper'

class NorifierTest < ActionMailer::TestCase
  test "order received" do
    mail = Norifier.order_received
    assert_equal "pragma store order confirmation", mail.subject

    assert_equal ["Tomek Lelek depot@example.com"], mail.from
    a
  end

  test "order shipped" do
    mail = Norifier.order_chipped
    assert_equal "pragma store order shipped", mail.subject

    assert_equal ["Tomek Lelek depot@example.com"], mail.from

  end

end
