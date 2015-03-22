'use strict'

Polymer 'subpage-resetpwd',
  observe:
    token: 'onChange'
    password: 'onChange'
    password2: 'onChange'

  formEnabled: false
  errorMsg: ''

  created: () ->
    @M = window.M['member']['resetpwd']
    @profile = window.profile

  onChange: () ->
    if @password and @password2
      if @password != @password2
        @errorMsg = @M.errors.notMatch
      else
        @errorMsg = ''
    else 
      @errorMsg = ''

    @formEnabled = not @profile and @token
    @enabled = @formEnabled and not @errorMsg

  resetPasswd: () ->
    this.$.ajax.resetPasswd(@token, @password) if @enabled
