'use strict'

Polymer 'subpage-login',
  errorMsg: ' '

  observe: {
    email: 'validateLoginForm'
    password: 'validateLoginForm'
  }

  ready: () ->
    @M = window.M['member']['login']
    @addEventListener 'user-access-denied', (e) ->
      @errorMsg = @M.invalidEmailOrPasswd
      @buttonDisabled = true

  logMeIn: () ->
    if not @buttonDisabled
      this.$.loginAjax.login()

  responseChanged: (o, n) ->
    @needResendActivationEmail = false
    if @response and @response.code != 0
      if @response.code == 9013
        @errorMsg = @M.tooManyFailure.format("120")
        @buttonDisabled = true
      else if @response.code == 1003
        @errorMsg = @M.userNotExist
        @buttonDisabled = true
      else if @response.code == 1004
        @errorMsg = @M.badPassword.format(@response.data.canRetryTime)
        @buttonDisabled = true
      else if @response.code == 1006
        @needResendActivationEmail = true
        @errorMsg = @M.emailNotVerified.format(@response.data.canRetryTime)
        @buttonDisabled = true

  validateLoginForm: () ->
    if not @email or not @password
      @errorMsg = ' '
      @buttonDisabled = true
    else if not @validateEmail(@email)
      @errorMsg = @M.emailInvalid
      @buttonDisabled = true
    else
      @errorMsg = ' '
      @buttonDisabled = false

  validateEmail: (email) ->
    window.config.emailRe.test(email)

