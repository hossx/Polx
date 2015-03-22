'use strict'

Polymer 'subpage-forgetpwd',
  ready: () ->
    @M = window.M['member']['forgetpwd']

  requestResetPasswd: () ->
    this.$.ajax.request(@email) if @email