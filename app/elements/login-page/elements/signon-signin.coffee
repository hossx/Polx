'use strict'

Polymer 'signon-signin',
  page: 'signin'
  email: ''
  message: null
  z: "1"

  ready: () ->
    @showRegistered()

  showSignin: () -> @page = "signin"
  showSignon: () -> @page = "signon"
  showForget: () -> @page = "forget"

  showRegistered: () ->
    @message = 
      title: "Confirm Your Membership"
      details: [
        "We just send you an email for your membership confirmation. You need to click on the link in the email to activate your account.",
        "Please give the email a couple of minutes to arrive. If you still don't find it in your mailbox after a while, go ahead and check the spam folder."
        "Thank you."]
    @page = "message"
    setTimeout ()=> 
      @page = "signin"
    , 10000
