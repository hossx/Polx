'use strict'

Polymer 'signon-signin',
  page: 'signin'
  email: ''
  message: null
  timeout: null
  z: "1"

  ready: () ->
    @showRegistered()

  showSignin: () -> @show("signin")
  showSignon: () -> @show("signon")
  showForget: () -> @show("forget")
  showSignout: () -> @show("signout")

  showRegistered: () ->
    @message =
      title: "Confirm Your Membership"
      details: [
        "We just send you an email for your membership confirmation. You need to click on the link in the email to activate your account.",
        "Please give the email a couple of minutes to arrive. If you still don't find it in your mailbox after a while, go ahead and check the spam folder."
        "Thank you."]
    @show("message")
    @delayShow("signin")

  showPasswordReset: () ->
    @message = 
      title: "Reset Password"
      details: [
        "We just send you an email with a link to reset your password. Your current password is still valid until a new one is set.",
        "Please give the email a couple of minutes to arrive. If you still don't find it in your mailbox after a while, go ahead and check the spam folder."
        "Thank you."]
    @show("message")
    @delayShow("signin")

  show: (page) ->
    clearTimeout(@timeout) if @timeout
    @timeout = null
    @page = page

  delayShow: (page, timeout) ->
    clearTimeout(@timeout) if @timeout
    @timeout = setTimeout ()=> 
      @page = page
      @timeout = null
    , 15000
