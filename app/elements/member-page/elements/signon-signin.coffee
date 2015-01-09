'use strict'

Polymer 'signon-signin',
  page: 'signin'

  ## general
  message: null
  timeout: null

  validateEmail: (email) ->
     re = /^[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}$/
     re.test(email)

  observe: {
    registerEmail: 'validateRegisterForm'
    registerPassword: 'validateRegisterForm'
    registerPassword2: 'validateRegisterForm'
    termsAgreed: 'validateRegisterForm'

    loginEmail: 'validateLoginForm'
    loginPassword: 'validateLoginForm'
  }

  translateErrorMessage: (m) ->
    if m == "RegisterUserFailed(EmailAlreadyRegistered)"
      "This email has been registered already."
    else if m == "LoginFailed(EmailNotVerified)"
      "This email has not been verified."
    else if m == 'LoginFailed(UserNotExist)' or m == 'LoginFailed(PasswordNotMatch)'
      "Either email or password is incorrect."
    else
      m

  ready: () ->
    @registerUrl = window.protocol.registerUrl()
    @loginUrl = window.protocol.loginUrl()

    this.$.registerForm.addEventListener 'submitting', (e) =>
      e.detail.formData.password = $.sha256b64(e.detail.formData.password)

    this.$.registerForm.addEventListener 'submitted', (e) =>
      console.debug(e)
      if e.detail.status > 299
        @fire("network-error", {'url': @registerUrl})
      else
        resp = JSON.parse(e.detail.response)
        if not resp.success
          @errorMsg = @translateErrorMessage(resp.message)
          @registerDisabled = true
        else
          @registerPassword = @registerPassword2 = ''
          @termsAgreed = false
          @fire("user-registered", {'uid': resp.message})
          @page = "registered"

    this.$.loginForm.addEventListener 'submitting', (e) =>
      console.log(e)
      e.detail.formData.password = $.sha256b64(e.detail.formData.password)

    this.$.loginForm.addEventListener 'submitted', (e) =>
      console.debug(e)
      if e.detail.status > 299
        @fire("network-error", {'url': @loginUrl})
      else
       
        resp = JSON.parse(e.detail.response)
        if not resp.success
          @errorMsg = @translateErrorMessage(resp.message)
        else
          console.log("Logged in as: " + resp.data.id)
          @fire("user-loggedin", {'uid': resp.data.id})


  ## register
  registerEmail: ''
  termsAgreed: false
  registerDisabled: true
  registerMe: () -> this.$.registerForm.submit()

  validateRegisterForm: ()->
    if not @registerEmail and not @registerPassword and not @registerPassword2
      @errorMsg = ''
      @registerDisabled = true
    else if not @registerEmail
      @errorMsg = "Please provide your email"
      @registerDisabled = true
    else if not @validateEmail(@registerEmail)
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
  loginEmail: ''
  loginDisabled: true
  logMeIn: () -> this.$.loginForm.submit()

  validateLoginForm: () ->
    if not @loginEmail and not @loginPassword 
      @errorMsg = ''
      @loginDisabled = true
    else if not @loginEmail
      @errorMsg = "Please provide your email"
      @loginDisabled = true
    else if not @validateEmail(@loginEmail)
      @errorMsg = "Your email address is invalid"
      @loginDisabled = true
    else if not @loginPassword
      @errorMsg = "Please provide your password"
      @loginDisabled = true
    else
      @errorMsg = ''
      @loginDisabled = false

  showSignin: () -> @show("signin")
  showSignon: () -> @show("signon")
  showForget: () -> @show("forget")
  showSignout: () -> @show("signout")

  pageChanged: (o, n) ->
    @errorMsg = ''
    if @page == 'registered'
      @showRegistered()
    else if @page == 'verified'
      @showVerified()
    else if @page == 'notverified'
      @showVerifyFailed()
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
        "We just send you an email to %s for your membership confirmation. You need to click on the link in the email to activate your account.".format(@registerEmail),
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

  showVerifyFailed: () ->
    @message =
      title: "Email Verification Failed"
      details: [
        "We cannot verify your email address.",
        "You many need to try again."]
    @show("message")
    @delayShow("signin")

  showPasswordRetrived: () ->
    @message = 
      title: "Check Your Email"
      details: [
        "We just send you an email to %s with a link to reset your password. Your current password is still valid until a new one is set.".format(@retrieveEmail),
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
