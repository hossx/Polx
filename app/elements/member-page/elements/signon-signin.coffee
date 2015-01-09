'use strict'

Polymer 'signon-signin',
  page: 'signon'

  ## general
  message: null
  timeout: null

  validateEmail: (email) ->
     re = /^[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}$/
     re.test(email)

  observe: {
    email: 'validateRegisterForm',
    registerPassword: 'validateRegisterForm'
    registerPassword2: 'validateRegisterForm'
    termsAgreed: 'validateRegisterForm'
  }

  translateErrorMessage: (m) ->
    if m == "RegisterUserFailed(EmailAlreadyRegistered)"
      "This email has been registered already"
    else 
      m

  ready: () ->
    @loginUrl = window.protocol.loginUrl()
    @registerUrl = window.protocol.registerUrl()

    this.$.registerForm.addEventListener 'submitting', (e) =>
      e.detail.formData.password = $.sha256b64(e.detail.formData.password)
      console.log(e)

    this.$.registerForm.addEventListener 'submitted', (e) =>
      console.log(e)
      if e.detail.status > 299
        @fire("network-error", {'url': @registerUrl})
      else
        resp = JSON.parse(e.detail.response)
        console.log(resp)
        console.log(resp.success)
        if not resp.success
          @errorMsg = @translateErrorMessage(resp.message)
          @registerDisabled = true
        else
          @registerPassword = @registerPassword2 = ''
          @termsAgreed = false
          @fire("user-registered", {'uid': resp.message})
          @page = "registered"


  ## register
  email: ''
  termsAgreed: false
  registerDisabled: true
  registerMe: () -> this.$.registerForm.submit()

  validateRegisterForm: ()->
    if not @email and not @registerPassword and not @registerPassword2
      @errorMsg = ''
      @registerDisabled = true
    else if not @email
      @errorMsg = "Provide provide your email"
      @registerDisabled = true
    else if not @validateEmail(@email)
      @errorMsg = "Your email address is invalid"
      @registerDisabled = true
    else if not @registerPassword and not @registerPassword2
      @errorMsg = "Please provide a password"
      @registerDisabled = true
    else if @registerPassword.length < 6
      @errorMsg = "Your password is too weak"
      @registerDisabled = true
    else if  @registerPassword != @registerPassword2
      @errorMsg = "Passwords do not match"
      @registerDisabled = true
    else
      @errorMsg = ''
      @registerDisabled = not @termsAgreed


  ## login
  loginMeIn: () ->
    @errorMsg = ''
    this.$.loginAjax.go()

  loginRespChanged: (o, n) ->
    if @loginResp
      console.debug(@loginResp)
      if @loginResp == ''
        @fire("network-error", {'url': @loginUrl})
      else if not @loginResp.success
        @errorMsg = "Incorrect username or password."
      else

  showSignin: () -> @show("signin")
  showSignon: () -> @show("signon")
  showForget: () -> @show("forget")
  showSignout: () -> @show("signout")

  pageChanged: (o, n) ->
    @errorMsg = ''
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
        "We just send you an email to %s for your membership confirmation. You need to click on the link in the email to activate your account.".format(@email),
        "Please give the email a couple of minutes to arrive. If you still don't find it in your mailbox after a while, go ahead and check the spam folder."
        "Thank you."]
    @show("message")
    @delayShow("signin")

  showVerified: () ->
    @message =
      title: "Email Verified"
      details: [
        "We have verified your email address",
        "You can take advantage of all Coinport services."
        "Happy trading!"]
    @show("message")
    @delayShow("signin")

  showPasswordRetrived: () ->
    @message = 
      title: "Check Your Email"
      details: [
        "We just send you an email to %s with a link to reset your password. Your current password is still valid until a new one is set.".format(@email),
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
