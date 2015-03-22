'use strict'

Polymer 'account-sidebar',
  ready: () ->
    @M = window.M['account']['sidebar']
  logout: () ->
    @fire('user-request-logout')
