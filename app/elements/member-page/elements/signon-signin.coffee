'use strict'

Polymer 'signon-signin',
  page: 'signin'
  email: ''
  message: null
  timeout: null

  showSignin: () -> @show("signin")
  showSignon: () -> @show("signon")
  showForget: () -> @show("forget")
  showSignout: () -> @show("signout")

  pageChanged: (o, n) ->
    if @page == 'registered'
      @showRegistered()
    if @page == 'verified'
      @showVerified()
    else if @page == 'retrieved'
      @showPasswordRetrived()
    else if @page == 'pwdchanged'
      @showPasswordChanged()
    else if @page == 'signedout'
      @showSignedout()

  showRegistered: () ->
    @message =
      title: "Check Your Email"
      details: [
        "We just send you an email for your membership confirmation. You need to click on the link in the email to activate your account.",
        "Please give the email a couple of minutes to arrive. If you still don't find it in your mailbox after a while, go ahead and check the spam folder."
        "Thank you."]
    @show("message")
    @delayShow("signin")

  showVerified: () ->
    @message =
      title: "Email Verified"
      details: [
        "We have verified your email address.",
        "You can take advantage of all Coinport services."
        "Happy trading!"]
    @show("message")
    @delayShow("signin")

  showPasswordRetrived: () ->
    @message = 
      title: "Check Your Email"
      details: [
        "We just send you an email with a link to reset your password. Your current password is still valid until a new one is set.",
        "Please give the email a couple of minutes to arrive. If you still don't find it in your mailbox after a while, go ahead and check the spam folder."
        "Thank you."]
    @show("message")
    @delayShow("signin")

  showPasswordChanged: () ->
    @message = 
      title: "Password Changed"
      details: [
        "Your password has bee successfully changed.",
        "Thank you."]
    @show("message")
    @delayShow("signin")

  showSignedout: () ->
    @message = 
      title: "Singed Out"
      details: [
        "You have successfully signed out.",
        "See you soon."]
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
