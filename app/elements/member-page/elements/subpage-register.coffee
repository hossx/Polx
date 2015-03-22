'use strict'

Polymer 'subpage-register',
  ## register
  validateEmail: (email) ->
   window.config.emailRe.test(email)

  observe: {
    email: 'validateRegisterForm'
    password: 'validateRegisterForm'
    password2: 'validateRegisterForm'
    termsAgreed: 'validateRegisterForm'
  }

  email: ''
  termsAgreed: false
  registerDisabled: true
  errorMsg: ''

  ready: () ->
    @M = window.M['member']['register']
    @addEventListener 'user-register-failed', (e) -> 
      @errorMsg =  @M.errRegisterFailed[e.detail.code]
      console.debug("------user-register-failed", e.detail.code, @errorMsg)
      @registerDisabled = true

  registerMe: () ->
    if not @registerDisabled
      this.$.ajax.register()

  validateRegisterForm: ()->
    if not @email and not @password and not @password2
      @errorMsg = ''
      @registerDisabled = true
    else if not @email
      @errorMsg = @M.errProvideEmail
      @registerDisabled = true
    else if @password and not @validateEmail(@email)
      @errorMsg = @M.errEmailInvalid
      @registerDisabled = true
    else if @password2 and @password.length < 6
      @errorMsg = @M.errPasswordTooSimple
      @registerDisabled = true
    else if @password and @password2 and @password != @password2
      @errorMsg = @M.errPasswordsMisMatch
      @registerDisabled = true
    else
      @errorMsg = ''
      @registerDisabled = not @termsAgreed