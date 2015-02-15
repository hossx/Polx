'use strict'

Polymer 'account-sidebar',
  logout: () ->
    @fire('user-request-logout')