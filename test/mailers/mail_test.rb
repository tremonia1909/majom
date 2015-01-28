class UserControllerTest < ActionController::TestCase
  test "welcome_mail" do
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post :welcome_mail, email: 'friend@example.com'
    end
    invite_email = ActionMailer::Base.deliveries.last

    assert_equal "Willkommen zu Majom", invite_email.subject
    assert_equal 'friend@example.com', invite_email.to[0]
    assert_match(/You have successfully signed up to Majom/, invite_email.body.to_s)
  end
end
