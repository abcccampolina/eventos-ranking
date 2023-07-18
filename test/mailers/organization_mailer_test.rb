require 'test_helper'

class OrganizationMailerTest < ActionMailer::TestCase
  test "send_bank_slip" do
    mail = OrganizationMailer.send_bank_slip
    assert_equal "Send bank slip", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
