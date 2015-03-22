'use strict'

Polymer 'subpage-resend-activation',
  ready: () ->
    @M = window.M['member']['resend-activation']

  requestResetPasswd: () ->
    console.log(@email)
    this.$.ajax.request(@email) if @email